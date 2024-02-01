import re
import tkinter as tk
from tkinter import messagebox
import psycopg2
from tkinter import ttk
import random
from config import *
import requests
from datetime import date, datetime, timedelta
from ttkthemes import ThemedStyle


def create_connection():
    conn = psycopg2.connect(host=host, user=user, password=password, dbname=db_name, client_encoding='UTF-8')
    return conn


def update_frame_title(data_display_frame, title):
    for widget in data_display_frame.winfo_children():
        if isinstance(widget, tk.Label):
            widget.destroy()
    title_label = tk.Label(data_display_frame, text=title, font=("Arial", 14), background="#f0f0f0")
    title_label.grid(row=0, column=0, columnspan=2, pady=(0, 5), rowspan=1)


def clear_convert_frame(convert_frame, data_display_frame):
    for widget in convert_frame.winfo_children():
        widget.destroy()

    convert_frame = ttk.Frame(data_display_frame)
    convert_frame.grid(row=2, column=0, pady=10)
    convert_frame.grid_remove()


def generate_random_inn():
    year = str(random.randint(0, 99)).zfill(2)
    month = str(random.randint(1, 12)).zfill(2)
    day = str(random.randint(1, 31)).zfill(2)
    return year + month + day + ''.join([str(random.randint(0, 9)) for _ in range(6)])


def show_users():
    user_window = tk.Toplevel(root)
    user_window.title("Данные о пользователях")

    try:
        with psycopg2.connect(host=host, user=user, password=password, database=db_name) as connection:
            print("Соединение прошло успешно.")

        with connection.cursor() as cur:
            cur.execute("SELECT user_id FROM users")
            user_ids = [row[0] for row in cur.fetchall()]

            iin_list = [generate_random_inn() for _ in user_ids]

            for user_id, iin in zip(user_ids, iin_list):
                cur.execute("UPDATE users SET IIN = %s WHERE user_id = %s", (iin, user_id))

        connection.commit()

        with connection.cursor() as cur:
            cur.execute("SELECT * FROM users")
            result = cur.fetchall()
            users_listbox = tk.Listbox(user_window, width=100, height=100)
            users_listbox.pack(fill=tk.BOTH, expand=True)

            for row in result:
                users_listbox.insert(0, f"User ID: {row[0]}, Name: {row[1]}, IIN: {row[2]}")

            scrollbar = tk.Scrollbar(user_window, orient=tk.VERTICAL, command=users_listbox.yview)
            scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
            users_listbox.config(yscrollcommand=scrollbar.set)

    except psycopg2.Error as er:
        print(f"Error in {er}")


def show_accounts():
    try:
        with psycopg2.connect(host=host, user=user, password=password, database=db_name) as connection:
            print("Соединение прошло успешно.")

        with connection.cursor() as cur:
            cur.execute("SELECT * FROM account")
            result = cur.fetchall()
            for row in result:
                print(row)

    except psycopg2.Error as er:
        print(f"Error in {er}")


def show_payment_history(user_id, data_display_frame, title, convert_frame):
    try:
        clear_convert_frame(convert_frame, data_display_frame)
        update_frame_title(data_display_frame, title)

        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT service, payment_date, paument_sum FROM paymenthistory WHERE user_id = %s",
                            (user_id,))
                result = cur.fetchall()

                style = ttk.Style(data_display_frame)
                style.theme_use("clam")

                tree = ttk.Treeview(data_display_frame, columns=("Service", "Date", "Amount"), show="headings")
                tree.heading("Service", text="Сервис")
                tree.heading("Date", text="Дата")
                tree.heading("Amount", text="Сумма")

                tree.grid(row=1, column=0, sticky="nsew")
                data_display_frame.rowconfigure(1, weight=1)
                data_display_frame.columnconfigure(0, weight=1)
                for row in result:
                    tree.insert("", "end", values=row)

    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось получить данные об истории платежей: {e}")


def show_payments(user_id, balance_label):
    try:
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT service FROM payments")
                result = cur.fetchall()

                payment_window = tk.Toplevel()
                payment_window.title("Список сервисов")

                tree = ttk.Treeview(payment_window, columns="Service", show="headings", height=15)
                tree.heading("Service", text="Сервис")

                for row in result:
                    tree.insert("", "end", values=row)

                tree.pack(expand=True, fill="both")

                amount_label = tk.Label(payment_window, text="Сумма:", font=("Arial", 14))
                amount_label.pack(pady=(0, 0))

                amount_entry = tk.Entry(payment_window, font=("Arial", 14))
                amount_entry.pack(pady=5)

                pay_button = tk.Button(payment_window, text="Оплатить",
                                       command=lambda: make_payment(user_id, amount_entry.get(), tree, payment_window,
                                                                    balance_label), font=("Arial", 14))
                pay_button.pack(pady=10)

                payment_window.geometry("400x500")
                payment_window.configure(bg="#f0f0f0")

    except psycopg2.Error as er:
        print(f"Error in {er}")


def make_payment(user_id, amount, tree, payment_window, balance_label):
    try:
        selected_item = tree.selection()
        if selected_item:
            selected_service = tree.item(selected_item)['values'][0]

            if not amount or not amount.isdigit():
                messagebox.showerror("Ошибка", "Введите корректную сумму для оплаты.")
                return

            current_remainder = get_current_remainder(user_id)

            if int(amount) > current_remainder:
                messagebox.showerror("Ошибка", "Недостаточно средств на счете.")
                return

            new_remainder = current_remainder - int(amount)

            update_remainder(user_id, new_remainder)

            payment_date = date.today()
            insert_payment_history(selected_service, amount, payment_date, user_id)

            messagebox.showinfo("Успех", "Оплата прошла успешно.")
            balance_label.config(text=f"Баланс: {new_remainder}")  # Обновление баланса
            payment_window.destroy()
        else:
            messagebox.showerror("Ошибка", "Выберите сервис для оплаты.")
    except psycopg2.Error as er:
        messagebox.showerror("Ошибка", f"Не удалось провести оплату: {er}")


def get_current_remainder(user_id):
    try:
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT remainder FROM creditcards WHERE user_id = %s", (user_id,))
                result = cur.fetchone()
                if result:
                    return result[0]
                else:
                    messagebox.showerror("Ошибка", "Не удалось получить остаток средств.")
                    return 0
    except psycopg2.Error as er:
        messagebox.showerror("Ошибка", f"Не удалось получить остаток средств: {er}")
        return 0


def update_remainder(user_id, new_remainder):
    try:
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("UPDATE creditcards SET remainder = %s WHERE user_id = %s", (new_remainder, user_id))
                connection.commit()
    except psycopg2.Error as er:
        messagebox.showerror("Ошибка", f"Не удалось обновить остаток средств: {er}")


def insert_payment_history(service, amount, payment_date, user_id):
    try:
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute(
                    "INSERT INTO paymenthistory (service, paument_sum, payment_date, user_id) VALUES (%s, %s, %s, %s)",
                    (service, amount, payment_date, user_id))
                connection.commit()
    except psycopg2.Error as er:
        messagebox.showerror("Ошибка", f"Не удалось добавить запись об оплате: {er}")


def apply_for_credit(user_id, balance_label):
    def validate_amount(input_str):
        return input_str.isdigit() or input_str == ""

    def submit_credit_application(user_id, amount_requested, term, balance_label, credit_window):
        if not amount_requested:
            messagebox.showerror("Ошибка", "Введите сумму")
            return

        try:
            amount_requested = int(amount_requested)
        except ValueError:
            messagebox.showerror("Ошибка", "Неверный формат суммы")
            return
        try:
            with create_connection() as connection:
                with connection.cursor() as cur:
                    cur.execute("INSERT INTO loanapplications (user_id, amount_requested, status) VALUES (%s, %s, %s)",
                                (user_id, amount_requested, "одобрено"))

                    current_date = datetime.now()

                    end_date = current_date + timedelta(days=term * 365)

                    cur.execute("INSERT INTO loans (user_id, interest, term, credit_sum) VALUES (%s, %s, %s, %s)",
                                (user_id, 13, end_date, amount_requested))

                    cur.execute("SELECT remainder FROM creditcards WHERE user_id = %s", (user_id,))
                    current_remainder = cur.fetchone()[0]

                    new_remainder = current_remainder + amount_requested

                    cur.execute("UPDATE creditcards SET remainder = %s WHERE user_id = %s", (new_remainder, user_id))

                    connection.commit()
                    messagebox.showinfo("Успешно", "Заявка на кредит одобрена")
                    balance_label.config(text=f"Баланс: {new_remainder}")
                    credit_window.destroy()
        except psycopg2.Error as e:
            messagebox.showerror("Ошибка", f"Не удалось получить данные о кредитах: {e}")

    credit_window = tk.Toplevel()
    credit_window.title("Заявка на кредит")
    credit_window.geometry("400x250")
    credit_window.configure(bg="#f0f0f0")

    interest_label = tk.Label(credit_window, text="Процентная ставка: 13%", font=("Arial", 12, "bold"), bg="#f0f0f0",
                              fg="#333")
    interest_label.pack(pady=10)

    amount_label = tk.Label(credit_window, text="Сумма кредита:", font=("Arial", 12), bg="#f0f0f0", fg="#333")
    amount_label.pack()

    validate_amount_cmd = credit_window.register(validate_amount)
    amount_entry = tk.Entry(credit_window, font=("Arial", 12), validate="key",
                            validatecommand=(validate_amount_cmd, "%P"), bg="#fff", fg="#333", relief="solid")
    amount_entry.pack()

    term_label = tk.Label(credit_window, text="Срок кредита (в годах):", font=("Arial", 12), bg="#f0f0f0", fg="#333")
    term_label.pack()

    term_values = [str(i) for i in range(1, 11)]
    selected_term = tk.StringVar(credit_window)
    selected_term.set(term_values[0])

    term_menu = tk.OptionMenu(credit_window, selected_term, *term_values)
    term_menu.config(font=("Arial", 12), bg="#fff", fg="#333", width=10, relief="solid")
    term_menu.pack()

    submit_button = tk.Button(credit_window, text="Отправить заявку",
                              command=lambda: submit_credit_application(user_id, amount_entry.get(),
                                                                        int(selected_term.get()), balance_label,
                                                                        credit_window), font=("Arial", 12, "bold"),
                              width=20, pady=5, relief="raised")
    submit_button.pack(pady=20)

    credit_window.mainloop()


def transactions(user_id, balance_label):
    def transfer_money():
        transfer_amount = amount_entry.get()

        if not transfer_amount:
            messagebox.showerror("Ошибка", "Введите сумму перевода")
            return

        try:
            transfer_amount = float(transfer_amount)
        except ValueError:
            messagebox.showerror("Ошибка", "Введите корректную сумму перевода")
            return

        try:
            transaction_type = selected_transaction_type.get()

            if transaction_type == "Карта":
                target_card_number = card_number_entry.get()

                if not target_card_number:
                    messagebox.showerror("Ошибка", "Введите номер карты получателя")
                    return

                if not re.match(r'^\d{4}-\d{4}-\d{4}-\d{4}$', target_card_number):
                    messagebox.showerror("Ошибка",
                                         "Неверный формат номера карты. Введите номер в формате: XXXX-XXXX-XXXX-XXXX")
                    return

                if target_card_number == get_user_card_number(user_id):
                    messagebox.showerror("Ошибка", "Вы не можете перевести средства на свою собственную карту.")
                    return

                perform_credit_to_card_transfer(user_id, target_card_number, transfer_amount)

            elif transaction_type == "Счета":
                from_account = selected_from_account.get()
                to_account = selected_to_account.get()

                if from_account == to_account:
                    messagebox.showerror("Ошибка", "Выберите различные счета для перевода.")
                    return

                perform_account_transfer(user_id, from_account, to_account, transfer_amount)

            messagebox.showinfo("Успех", "Перевод успешно выполнен.")
            balance_label.config(text=f"Баланс: {get_current_remainder(user_id)}")
            top.destroy()

        except psycopg2.Error as e:
            messagebox.showerror("Ошибка", f"Не удалось выполнить перевод: {e}")

    def perform_credit_to_card_transfer(user_id, target_card_number, transfer_amount):
        try:
            if not target_card_number or not transfer_amount:
                messagebox.showerror("Ошибка", "Введите все данные")
                return

            with create_connection() as connection:
                with connection.cursor() as cur:
                    cur.execute("SELECT remainder FROM creditcards WHERE user_id = %s", (user_id,))
                    sender_remainder = cur.fetchone()

            if not sender_remainder or sender_remainder[0] < transfer_amount:
                messagebox.showerror("Ошибка", "Недостаточно средств на вашей карте.")
                return

            with create_connection() as connection:
                with connection.cursor() as cur:
                    cur.execute("SELECT user_id, remainder FROM creditcards WHERE card_num = %s",
                                (target_card_number,))
                    target_card_info = cur.fetchone()

            if not target_card_info:
                messagebox.showerror("Ошибка", "Карта с указанным номером не найдена.")
                return

            with create_connection() as connection:
                with connection.cursor() as cur:
                    cur.execute("UPDATE creditcards SET remainder = remainder - %s WHERE user_id = %s",
                                (transfer_amount, user_id))

                    cur.execute("UPDATE creditcards SET remainder = remainder + %s WHERE user_id = %s",
                                (transfer_amount, target_card_info[0]))

                    cur.execute(
                        "INSERT INTO transactions (user_id, card_num, sum, date_time_tr) VALUES (%s, %s, %s, CURRENT_TIMESTAMP)",
                        (user_id, target_card_number, transfer_amount))

                    connection.commit()

        except psycopg2.Error as e:
            messagebox.showerror("Ошибка", f"Не удалось выполнить перевод: {e}")

    def perform_account_transfer(user_id, from_account, to_account, transfer_amount):
        try:
            with create_connection() as connection:
                with connection.cursor() as cur:
                    from_balance_column = "remainder" if from_account == "creditcards" else "balance"
                    to_balance_column = "remainder" if to_account == "creditcards" else "balance"

                    cur.execute(f"SELECT {from_balance_column} FROM {from_account} WHERE user_id = %s", (user_id,))
                    sender_remainder = cur.fetchone()

                    if not sender_remainder or sender_remainder[0] < transfer_amount:
                        messagebox.showerror("Ошибка", "Недостаточно средств на вашем счете.")
                        return

                    cur.execute(
                        f"UPDATE {from_account} SET {from_balance_column} = {from_balance_column} - %s WHERE user_id = %s",
                        (transfer_amount, user_id))
                    cur.execute(
                        f"UPDATE {to_account} SET {to_balance_column} = {to_balance_column} + %s WHERE user_id = %s",
                        (transfer_amount, user_id))

                    connection.commit()

        except psycopg2.Error as e:
            messagebox.showerror("Ошибка", f"Не удалось выполнить перевод: {e}")

    def get_user_card_number(user_id):
        try:
            with create_connection() as connection:
                with connection.cursor() as cur:
                    cur.execute("SELECT card_num FROM creditcards WHERE user_id = %s", (user_id,))
                    result = cur.fetchone()
                    return result[0] if result else None
        except psycopg2.Error as e:
            messagebox.showerror("Ошибка", f"Ошибка при получении номера карты: {e}")
            return None

    def update_ui_for_transaction_type():
        if selected_transaction_type.get() == "Карта":
            card_number_label.grid(row=1, column=0, pady=(20, 5), padx=20, sticky="w")
            account_number_label.grid_remove()

            card_number_entry.grid(row=1, column=1, pady=(20, 5), padx=20)
            account_number_entry.grid_remove()

            from_account_label.grid_remove()
            to_account_label.grid_remove()
            from_account_menu.grid_remove()
            to_account_menu.grid_remove()

        elif selected_transaction_type.get() == "Счета":
            card_number_label.grid_remove()
            account_number_label.grid_remove()

            card_number_entry.grid_remove()
            account_number_entry.grid_remove()

            from_account_label.grid(row=2, column=0, pady=(20, 5), padx=20, sticky="w")
            to_account_label.grid(row=3, column=0, pady=(20, 5), padx=20, sticky="w")
            from_account_menu.grid(row=2, column=1, pady=(20, 5), padx=20)
            to_account_menu.grid(row=3, column=1, pady=(20, 5), padx=20)

    top = tk.Toplevel()
    top.title("Перевод средств")
    top.geometry("600x400")
    top.configure(bg="#f0f0f0")
    top.resizable(False, False)

    frame = tk.Frame(top, bg="#f0f0f0")
    frame.pack(pady=50)

    transaction_type_label = tk.Label(frame, text="Тип транзакции:", font=("Arial", 16), bg="#f0f0f0", fg="#333")
    transaction_type_label.grid(row=0, column=0, pady=(20, 5), padx=20, sticky="w")

    transaction_type_values = ["Карта", "Счета"]
    selected_transaction_type = tk.StringVar(top)
    selected_transaction_type.set(transaction_type_values[0])
    transaction_type_menu = tk.OptionMenu(frame, selected_transaction_type, *transaction_type_values)
    transaction_type_menu.grid(row=0, column=1, pady=(20, 5), padx=20)
    selected_transaction_type.trace_add("write", lambda *args: update_ui_for_transaction_type())

    card_number_label = tk.Label(frame, text="Номер карты получателя:", font=("Arial", 16), bg="#f0f0f0", fg="#333")
    card_number_label.grid(row=1, column=0, pady=(20, 5), padx=20, sticky="w")

    card_number_entry = tk.Entry(frame, font=("Arial", 16))
    card_number_entry.grid(row=1, column=1, pady=(20, 5), padx=20)

    account_number_label = tk.Label(frame, text="Номер счета получателя:", font=("Arial", 16), bg="#f0f0f0", fg="#333")
    account_number_label.grid(row=1, column=0, pady=(20, 5), padx=20, sticky="w")

    account_number_entry = tk.Entry(frame, font=("Arial", 16))
    account_number_entry.grid(row=1, column=1, pady=(20, 5), padx=20)
    account_number_label.grid_remove()
    account_number_entry.grid_remove()

    from_account_label = tk.Label(frame, text="От счета:", font=("Arial", 16), bg="#f0f0f0", fg="#333")
    from_account_label.grid(row=2, column=0, pady=(20, 5), padx=20, sticky="w")

    to_account_label = tk.Label(frame, text="На счет:", font=("Arial", 16), bg="#f0f0f0", fg="#333")
    to_account_label.grid(row=3, column=0, pady=(20, 5), padx=20, sticky="w")

    account_list = ["creditcards", "account"]
    selected_from_account = tk.StringVar(top)
    selected_from_account.set(account_list[0])
    from_account_menu = tk.OptionMenu(frame, selected_from_account, *account_list)

    selected_to_account = tk.StringVar(top)
    selected_to_account.set(account_list[1])
    to_account_menu = tk.OptionMenu(frame, selected_to_account, *account_list)

    from_account_menu.grid(row=2, column=1, pady=(20, 5), padx=20)
    to_account_menu.grid(row=3, column=1, pady=(20, 5), padx=20)
    from_account_label.grid_remove()
    to_account_label.grid_remove()
    from_account_menu.grid_remove()
    to_account_menu.grid_remove()

    amount_label = tk.Label(frame, text="Сумма перевода:", font=("Arial", 16), bg="#f0f0f0", fg="#333")
    amount_label.grid(row=4, column=0, pady=(20, 5), padx=20, sticky="w")

    amount_entry = tk.Entry(frame, font=("Arial", 16))
    amount_entry.grid(row=4, column=1, pady=(20, 5), padx=20)

    transfer_button = tk.Button(frame, text="Перевести", command=transfer_money, font=("Arial", 16), bg="#4CAF50",
                                fg="white")
    transfer_button.grid(row=5, columnspan=2, pady=20)

    top.mainloop()


def show_transactions(user_id, data_display_frame, title, convert_frame):
    try:
        clear_convert_frame(convert_frame, data_display_frame)
        update_frame_title(data_display_frame, title)
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT card_num, sum, date_time_tr FROM transactions WHERE user_id = %s", (user_id,))
                transactions_data = cur.fetchall()

        tree = ttk.Treeview(data_display_frame, columns=("Card Number", "Sum", "Date and Time"), show="headings")
        tree.heading("Card Number", text="Номер карты")
        tree.heading("Sum", text="Сумма")
        tree.heading("Date and Time", text="Дата и время")

        style = ttk.Style(data_display_frame)
        style.theme_use("clam")

        tree.grid(row=1, column=0, sticky="nsew")
        data_display_frame.rowconfigure(1, weight=1)
        data_display_frame.columnconfigure(0, weight=1)

        for row in transactions_data:
            tree.insert("", "end", values=row)

    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось получить данные о переводах: {e}")


def show_user_loans(user_id, data_display_frame, title, convert_frame):
    try:
        clear_convert_frame(convert_frame, data_display_frame)
        update_frame_title(data_display_frame, title)

        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT interest, term, credit_sum FROM loans WHERE user_id = %s", (user_id,))
                result = cur.fetchall()

                tree = ttk.Treeview(data_display_frame, columns=["Interest", "Term", "Credit Sum"], show="headings")
                tree.heading("Interest", text="Процентная ставка")
                tree.heading("Term", text="Срок")
                tree.heading("Credit Sum", text="Сумма кредита")

                style = ttk.Style(data_display_frame)
                style.theme_use("clam")

                tree.grid(row=1, column=0, sticky="nsew")
                data_display_frame.rowconfigure(1, weight=1)
                data_display_frame.columnconfigure(0, weight=1)

                for row in result:
                    tree.insert("", "end", values=row)

    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось получить данные о кредитах: {e}")


def show_currency_rates(data_display_frame, title):
    def convert_currency():
        try:
            selected_currency = currency_menu.get()
            amount = float(amount_entry.get())

            currency_rate = currency_rates[selected_currency]

            if selected_currency != 'KZT':
                converted_amount = round(amount * currency_rate, 2)
            else:
                converted_amount = amount / currency_rate

            messagebox.showinfo("Конвертация валюты", f"{amount} {selected_currency} = {converted_amount} KZT")
        except ValueError:
            messagebox.showerror("Ошибка", "Введите корректное число для конвертации.")
        except KeyError:
            messagebox.showerror("Ошибка", "Выберите валюту для конвертации.")

    try:
        update_frame_title(data_display_frame, title)
        api_url = "https://api.exchangerate-api.com/v4/latest/KZT"
        response = requests.get(api_url)
        response.raise_for_status()
        data = response.json()

        usd_to_kzt_rate = round(1 / data["rates"]["USD"], 1)
        eur_to_kzt_rate = round(1 / data["rates"]["EUR"], 2)
        rub_to_kzt_rate = round(1 / data["rates"]["RUB"], 2)


        currency_rates = {
            "USD": usd_to_kzt_rate,
            "EUR": eur_to_kzt_rate,
            "RUB": rub_to_kzt_rate
        }

        currency_names = list(currency_rates.keys())

        tree = ttk.Treeview(data_display_frame, columns=("Currency", "Rate"), show="headings")
        tree.heading("Currency", text="Валюта")
        tree.heading("Rate", text="Курс")

        tree.grid(row=1, column=0, sticky="nsew")
        data_display_frame.rowconfigure(1, weight=1)
        data_display_frame.columnconfigure(0, weight=1)

        convert_frame = ttk.Frame(data_display_frame)
        convert_frame.grid(row=2, column=0, pady=10)

        selected_currency_var = tk.StringVar()
        currency_menu = ttk.Combobox(convert_frame, textvariable=selected_currency_var, values=currency_names,
                                     state="readonly", width=10)

        style = ThemedStyle(convert_frame)
        style.set_theme("clam")
        style.configure("TCombobox", background="#FFFFFF", foreground="#000000", fieldbackground="#F0F0F0",
                        font=("Arial", 12))

        currency_menu.grid(row=0, column=0, padx=5, pady=5)
        amount_var = tk.StringVar()
        amount_entry = ttk.Entry(convert_frame, textvariable=amount_var, width=10)
        amount_entry.grid(row=0, column=1, padx=5, pady=5)
        convert_button = ttk.Button(convert_frame, text="Конвертировать", command=convert_currency, width=15)
        convert_button.grid(row=0, column=2, padx=5, pady=5)

        style.theme_use("clam")

        for currency, rate in currency_rates.items():
            tree.insert("", "end", values=(currency, rate))

    except Exception as e:
        messagebox.showerror("Ошибка", f"Не удалось получить курсы валют: {e}")


def apply_for_insurance_policy(user_id):
    def validate_vehicle_num(car_number):
        if not car_number:
            messagebox.showerror("Ошибка", "Введите номер машины")
            return False
        if not re.match(r'^\d{3}[A-Z]{3}\d{2}$', car_number) or not (0 <= int(car_number[0:3]) <= 999) or not (
                1 <= int(car_number[6:]) <= 20):
            messagebox.showerror("Ошибка", "Неверный формат номера машины. Введите номер в формате: 238ALH01")
            return False
        return True

    def get_insurance_policy_info(user_id, car_number, insurance_type, insurance_window):
        if not validate_vehicle_num(car_number):
            return
        try:
            with create_connection() as connection:
                with connection.cursor() as cur:
                    current_date = datetime.now().date()

                    cur.execute(
                        "INSERT INTO insurancepolicies (user_id, policy_type, vehicle_num, started_date) VALUES (%s, %s, %s, %s)",
                        (user_id, insurance_type, car_number, current_date))

                    connection.commit()
                    messagebox.showinfo("Успешно", "Заявка на страховой полис успешно подана!")
                    insurance_window.destroy()
        except psycopg2.Error as e:
            messagebox.showerror("Ошибка", f"Не удалось подать заявку на страховой полис: {e}")

    insurance_window = tk.Toplevel()
    insurance_window.title("Заявка на страховой полис")
    insurance_window.geometry("400x300")
    insurance_window.configure(bg="#E0E5E5")

    frame = tk.Frame(insurance_window, bg="#FFFFFF", bd=1, relief="solid")
    frame.pack(fill="both", expand=True)

    term_label = tk.Label(frame, text="Номер машины:", font=("Arial", 12), bg="#FFFFFF", fg="#333")
    term_label.grid(row=0, column=0, pady=(20, 5), sticky="w")

    car_number_entry = tk.Entry(frame, font=("Arial", 12))
    car_number_entry.grid(row=0, column=1, pady=(20, 5), padx=10)

    insurance_type_label = tk.Label(frame, text="Тип страхового полиса:", font=("Arial", 12), bg="#FFFFFF",
                                    fg="#333")
    insurance_type_label.grid(row=1, column=0, pady=5, sticky="w")

    insurance_type_values = ["КАСКО", "ОСАГО"]
    selected_insurance_type = tk.StringVar(insurance_window)
    selected_insurance_type.set(insurance_type_values[0])

    def update_max_payment(*args):
        if selected_insurance_type.get() == "КАСКО":
            max_payment_value.set("15 000 000")
        elif selected_insurance_type.get() == "ОСАГО":
            max_payment_value.set("3 500 000")

    insurance_type_menu = tk.OptionMenu(frame, selected_insurance_type, *insurance_type_values,
                                        command=update_max_payment)
    insurance_type_menu.config(font=("Arial", 12), bg="#FFFFFF", fg="#333", width=15)
    insurance_type_menu.grid(row=1, column=1, pady=5, padx=10, sticky="ew")

    max_payment_label = tk.Label(frame, text="Максимальная выплата: ", font=("Arial", 12), bg="#FFFFFF",
                                 fg="#333")
    max_payment_label.grid(row=2, column=0, pady=5, sticky="w")

    max_payment_value = tk.StringVar(insurance_window)

    max_payment_display = tk.Label(frame, textvariable=max_payment_value, font=("Arial", 12), bg="#FFFFFF",
                                   fg="#333")
    max_payment_display.grid(row=2, column=1, pady=5, padx=10, sticky="w")

    update_max_payment()

    submit_button = tk.Button(frame, text="Подать на страховой полис",
                              command=lambda: get_insurance_policy_info(user_id, car_number_entry.get(),
                                                                        selected_insurance_type.get(),
                                                                        insurance_window),
                              font=("Arial", 12, "bold"), width=25, pady=10)
    submit_button.grid(row=3, columnspan=2, pady=20)



def show_insurance_policies(user_id, data_display_frame, title, convert_frame):
    try:
        clear_convert_frame(convert_frame, data_display_frame)
        update_frame_title(data_display_frame, title)

        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT policy_type, vehicle_num, started_date FROM insurancepolicies WHERE user_id = %s",
                            (user_id,))
                res = cur.fetchall()

                style = ttk.Style(data_display_frame)
                style.theme_use("clam")

                tree = ttk.Treeview(data_display_frame, columns=("Policy Type", "Vehicle num", "Started date"),
                                    show="headings", style="Custom.Treeview")
                tree.heading("Policy Type", text="Тип полиса")
                tree.heading("Vehicle num", text="Номер авто")
                tree.heading("Started date", text="Дата регистрации ")

                tree.grid(row=1, column=0, sticky="nsew")
                data_display_frame.rowconfigure(1, weight=1)
                data_display_frame.columnconfigure(0, weight=1)

                for row in res:
                    tree.insert("", "end", values=row)

    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось получить данные о страховых полисах: {e}")



def show_branches_data(data_display_frame, title, convert_frame):
    try:
        clear_convert_frame(convert_frame, data_display_frame)
        update_frame_title(data_display_frame, title)

        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT b.branch_name, b.branch_adress, city FROM branches as b")
                result = cur.fetchall()

                tree = ttk.Treeview(data_display_frame, columns=("Branch Name", "Branch Address", "City"),
                                    show="headings")
                tree.heading("Branch Name", text="Название филиала")
                tree.heading("Branch Address", text="Адрес филиала")
                tree.heading("City", text="Город")

                style = ttk.Style(data_display_frame)
                style.theme_use("clam")

                tree.grid(row=1, column=0, sticky="nsew")
                data_display_frame.rowconfigure(1, weight=1)
                data_display_frame.columnconfigure(0, weight=1)

                vsb = ttk.Scrollbar(data_display_frame, orient="vertical", command=tree.yview)
                vsb.grid(row=1, column=1, sticky="ns")
                tree.configure(yscrollcommand=vsb.set)

                for row in result:
                    tree.insert("", "end", values=row)

    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось получить данные о филиалах: {e}")


def open_deposit(user_id):
    try:
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT COUNT(*) FROM account WHERE user_id = %s AND type_account = %s",
                            (user_id, "Депозит"))
                deposit_count = cur.fetchone()[0]

                if deposit_count > 0:
                    messagebox.showinfo("Информация", "У вас уже есть открытый депозит")
                else:
                    cur.execute("INSERT INTO account (user_id, balance, type_account) VALUES (%s, %s, %s)",
                                (user_id, 0, "Депозит"))
                    connection.commit()
                    messagebox.showinfo("Успех", "Депозит успешно открыт")
    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Произошла ошибка: {e}")


def show_user_deposits(user_id, data_display_frame, title, convert_frame):
    try:
        clear_convert_frame(convert_frame, data_display_frame)
        update_frame_title(data_display_frame, title)

        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT balance, type_account FROM account WHERE user_id = %s AND type_account = %s",
                            (user_id, "Депозит"))
                result = cur.fetchall()

                tree = ttk.Treeview(data_display_frame, columns=("Balance", "Type"),
                                    show="headings")
                tree.heading("Balance", text="Баланс")
                tree.heading("Type", text="Тип счета")

                style = ttk.Style(data_display_frame)
                style.theme_use("clam")

                tree.grid(row=1, column=0, sticky="nsew")
                data_display_frame.rowconfigure(1, weight=1)
                data_display_frame.columnconfigure(0, weight=1)
                for row in result:
                    tree.insert("", "end", values=row)

    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось получить данные о депозитах: {e}")


def open_login_window():
    def login(iin, password):
        try:
            with create_connection() as connection:
                with connection.cursor() as cur:
                    cur.execute("SELECT * FROM users WHERE iin = %s AND password = %s", (iin, password))
                    user_data = cur.fetchone()

                    if user_data:
                        messagebox.showinfo("Успех", "Вы успешно вошли в систему!")
                        login_window.destroy()
                        show_main_window(user_data[0])
                    else:
                        messagebox.showerror("Ошибка", "Неверные данные пользователя!")

        except psycopg2.Error as er:
            messagebox.showerror("Ошибка", f"Ошибка при входе: {er}")

    login_window = tk.Toplevel(root)
    login_window.title("Вход")
    login_window.geometry("400x300")
    login_window.configure(bg="#f0f0f0")

    label_username = tk.Label(login_window, text="ИИН:", font=("Arial", 14), bg="#f0f0f0")
    label_username.pack(pady=10)
    entry_username = tk.Entry(login_window, font=("Arial", 14))
    entry_username.pack()

    label_password = tk.Label(login_window, text="Пароль:", font=("Arial", 14), bg="#f0f0f0")
    label_password.pack(pady=10)
    entry_password = tk.Entry(login_window, show="*", font=("Arial", 14))
    entry_password.pack()

    btn_login = tk.Button(login_window, text="Войти", command=lambda: login(entry_username.get(), entry_password.get()),
                          font=("Arial", 14), width=20, height=1)
    btn_login.pack(pady=20)


def open_register_window():
    def register(first_name, last_name, iin, password):
        try:
            with create_connection() as connection:
                with connection.cursor() as cur:
                    cur.execute(
                        "INSERT INTO users (first_name, last_name, iin, password) VALUES (%s, %s, %s, %s) RETURNING user_id",
                        (first_name, last_name, iin, password))
                    connection.commit()
                    user_id = cur.fetchone()[0]
                    messagebox.showinfo("Успех", "Регистрация прошла успешно!")
                    register_window.destroy()
                    show_main_window(user_id)
        except psycopg2.Error as er:
            messagebox.showerror("Ошибка", f"Ошибка при регистрации: {er}")

    register_window = tk.Toplevel(root)
    register_window.title("Регистрация")
    register_window.geometry("400x400")
    register_window.configure(bg="#f0f0f0")

    label_entry_userfirstname = tk.Label(register_window, text="Имя:", font=("Arial", 14), bg="#f0f0f0")
    label_entry_userfirstname.pack(pady=10)
    entry_userfirstname = tk.Entry(register_window, font=("Arial", 14))
    entry_userfirstname.pack()

    label_entry_lastname = tk.Label(register_window, text="Фамилия:", font=("Arial", 14), bg="#f0f0f0")
    label_entry_lastname.pack(pady=10)
    entry_lastanme = tk.Entry(register_window, font=("Arial", 14))
    entry_lastanme.pack()

    label_username = tk.Label(register_window, text="ИИН:", font=("Arial", 14), bg="#f0f0f0")
    label_username.pack(pady=10)
    entry_username = tk.Entry(register_window, font=("Arial", 14))
    entry_username.pack()

    label_password = tk.Label(register_window, text="Пароль:", font=("Arial", 14), bg="#f0f0f0")
    label_password.pack(pady=10)
    entry_password = tk.Entry(register_window, show="*", font=("Arial", 14))
    entry_password.pack()

    btn_register = tk.Button(register_window, text="Зарегистрироваться",
                             command=lambda: register(entry_userfirstname.get(), entry_lastanme.get(),
                                                      entry_username.get(), entry_password.get()), font=("Arial", 14))
    btn_register.pack(pady=20)


def card_exists_for_user(user_id):
    try:
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT * FROM creditcards WHERE user_id = %s", (user_id,))
                return cur.fetchone() is not None
    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Ошибка при проверке наличия карты: {e}")
        return False


def open_credit_card(user_id, card_num_label, balance_label):
    if card_exists_for_user(user_id):
        root = tk.Tk()
        root.withdraw()  #
        result = messagebox.askquestion("Уже есть карта", "У вас уже есть карта. Открыть новую карту?")
        if result == "yes":
            update_existing_credit_card(user_id, card_num_label)
        else:
            messagebox.showinfo("Отмена", "Оставлена текущая карта.")
    else:
        create_new_credit_card(user_id, card_num_label, balance_label)


def create_new_credit_card(user_id, card_num_label, balance_label):
    card_number = generate_card_number()
    validity_date = date.today()
    try:
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute(
                    "INSERT INTO creditcards (user_id, card_num, validity, remainder) VALUES (%s, %s, %s, %s)",
                    (user_id, card_number, validity_date, 0))
                connection.commit()

        messagebox.showinfo("Успех", "Карта успешно открыта!")
        card_num_label.config(text=f"Номер карты: {card_number}")
        balance_label.config(text=f"Баланс: {0}")
    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось открыть карту: {e}")


def update_existing_credit_card(user_id, card_num_label):
    card_number = generate_card_number()
    validity_date = date.today()
    try:
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute(
                    "UPDATE creditcards SET card_num = %s, validity = %s WHERE user_id = %s",
                    (card_number, validity_date, user_id))
                connection.commit()

        messagebox.showinfo("Успех", "Карта успешно обновлена!")
        card_num_label.config(text=f"Номер карты: {card_number}")
    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось обновить карту: {e}")


def generate_card_number():
    card_number = "-".join(["".join([str(random.randint(0, 9)) for _ in range(4)]) for _ in range(4)])
    return card_number


def show_main_window(user_id):
    root.withdraw()
    main_window = tk.Tk()
    main_window.title("Банковская система")
    main_window.geometry('750x750')
    button_font = ("Arial", 14)

    menubar = tk.Menu(main_window)
    main_window.config(menu=menubar)

    def get_user_data(user_id):
        try:
            with psycopg2.connect(host=host, user=user, password=password, database=db_name,
                                  client_encoding='utf-8') as connection:
                with connection.cursor() as cur:
                    cur.execute(
                        "SELECT u.first_name, u.last_name, u.iin, cc.card_num, cc.remainder FROM users as u LEFT JOIN creditcards as cc ON u.user_id = cc.user_id WHERE u.user_id = %s",
                        (user_id,))
                    user_data = cur.fetchone()
                    return user_data
        except psycopg2.Error as e:
            messagebox.showerror("Ошибка", f"Не удалось получить данные о пользователе: {e}")
            return None

    def display_user_data(user_id):
        user_data = get_user_data(user_id)
        if user_data:
            first_name, last_name, iin, card_num, remainder = user_data

            user_info_frame = tk.Frame(main_window)
            user_info_frame.grid(row=0, column=0, sticky='nw', padx=10, pady=10)

            user_info_label = tk.Label(user_info_frame, text=f"ФИО: {first_name} {last_name}", font=("Arial", 14))
            user_info_label.grid(row=0, column=0, sticky='nw')

            iin_label = tk.Label(user_info_frame, text=f"ИИН: {iin}", font=("Arial", 14))
            iin_label.grid(row=1, column=0, sticky='nw')

            card_num_label = tk.Label(user_info_frame, text=f"Номер карты: {card_num}", font=("Arial", 14))
            card_num_label.grid(row=2, column=0, sticky='nw')

            balance_label = tk.Label(user_info_frame, text=f"Баланс: {remainder}", font=("Arial", 14))
            balance_label.grid(row=3, column=0, sticky='nw')

            options_menu = tk.Menu(menubar, tearoff=0)
            menubar.add_cascade(label="Кредиты", menu=options_menu)

            options_menu.add_command(label="Текущие кредиты",
                                     command=lambda: show_user_loans(user_id, data_display_frame, "Текщие кредиты",
                                                                     data_display_frame))
            options_menu.add_command(label="Заявка на кредит", command=lambda: apply_for_credit(user_id, balance_label))

            insurance_menu = tk.Menu(menubar, tearoff=0)
            menubar.add_cascade(label="Страховые полисы", menu=insurance_menu)
            insurance_menu.add_command(label="Просмотр текущих полисов",
                                       command=lambda: show_insurance_policies(user_id, data_display_frame,
                                                                               "Текущие полисы", data_display_frame))
            insurance_menu.add_command(label="Подать заявку на страховой полис",
                                       command=lambda: apply_for_insurance_policy(user_id))

            payment_menu = tk.Menu(menubar, tearoff=0)
            menubar.add_cascade(label="Платежи", menu=payment_menu)
            payment_menu.add_command(label="История платежей",
                                     command=lambda: show_payment_history(user_id, data_display_frame,
                                                                          "История платежей", data_display_frame))
            payment_menu.add_command(label="Платежи", command=lambda: show_payments(user_id, balance_label))

            credit_menu = tk.Menu(menubar, tearoff=0)
            menubar.add_cascade(label="Счета", menu=credit_menu)

            credit_menu.add_command(label="Открыть депозит", command=lambda: open_deposit(user_id))
            credit_menu.add_command(label="Текущие депозиты",
                                    command=lambda: show_user_deposits(user_id, data_display_frame, "Текущие депозиты", data_display_frame))

            transaction = tk.Menu(menubar, tearoff=0)
            menubar.add_cascade(label="Переводы", menu=transaction)

            transaction.add_command(label="Перевести",
                                    command=lambda: transactions(user_id, balance_label))
            transaction.add_command(label="История переводов",
                                    command=lambda: show_transactions(user_id, data_display_frame, "История переводов",
                                                                      data_display_frame))

            buttons_frame = tk.Frame(main_window)
            buttons_frame.grid(row=0, column=1, sticky='ne', padx=10, pady=10)

            button_width = 20

            accounts_button = tk.Button(buttons_frame, text="Открыть карту",
                                        command=lambda: open_credit_card(user_id, card_num_label, balance_label),
                                        font=button_font,
                                        width=button_width)
            accounts_button.grid(row=0, column=2, sticky="ne", padx=10, pady=5)

            branches_button = tk.Button(buttons_frame, text="Филиалы",
                                        command=lambda: show_branches_data(data_display_frame, "Филиалы",
                                                                           data_display_frame),
                                        font=button_font, width=button_width)
            branches_button.grid(row=2, column=2, sticky="ne", padx=10, pady=5)

            currency_button = tk.Button(buttons_frame, text="Курсы валют",
                                        command=lambda: show_currency_rates(data_display_frame, title="Курсы волют"),
                                        font=button_font,
                                        width=button_width)
            currency_button.grid(row=3, column=2, sticky="ne", padx=10, pady=5)

            currency_label = tk.Label(main_window, font=("Arial", 12))
            currency_label.grid(row=1, column=0, sticky="se", padx=10, pady=10)

            def edit_user(user_id):
                def save_changes(user_id):
                    new_first_name = entry_first_name.get()
                    new_last_name = entry_last_name.get()

                    try:
                        with create_connection() as connection:
                            with connection.cursor() as cur:
                                cur.execute("UPDATE users SET first_name = %s, last_name = %s WHERE user_id = %s",
                                            (new_first_name, new_last_name, user_id))
                                connection.commit()  # Подтверждаем изменения в базе данных
                                messagebox.showinfo("Успех", "Данные пользователя успешно обновлены!")

                                updated_user_data = get_user_data(user_id)
                                if updated_user_data:
                                    first_name, last_name, iin, card_num, remainder = updated_user_data

                                    user_info_label.config(text=f"ФИО: {first_name} {last_name}")
                                    iin_label.config(text=f"ИИН: {iin}")
                                    card_num_label.config(text=f"Номер карты: {card_num}")
                                    balance_label.config(text=f"Баланс: {remainder}")
                                    edit_window.destroy()
                    except psycopg2.Error as e:
                        messagebox.showerror("Ошибка", f"Ошибка при обновлении данных пользователя: {e}")

                edit_window = tk.Toplevel()
                edit_window.title("Редактирование данных пользователя")

                label_first_name = tk.Label(edit_window, text="Имя:", font=("Arial", 14))
                label_first_name.grid(row=0, column=0, padx=10, pady=10)
                entry_first_name = tk.Entry(edit_window, font=("Arial", 14))
                entry_first_name.grid(row=0, column=1, padx=10, pady=10)

                label_last_name = tk.Label(edit_window, text="Фамилия:", font=("Arial", 14))
                label_last_name.grid(row=1, column=0, padx=10, pady=10)
                entry_last_name = tk.Entry(edit_window, font=("Arial", 14))
                entry_last_name.grid(row=1, column=1, padx=10, pady=10)

                btn_save_changes = tk.Button(edit_window, text="Сохранить изменения",
                                             command=lambda: save_changes(user_id),
                                             font=("Arial", 14))
                btn_save_changes.grid(row=2, column=0, columnspan=2, padx=10, pady=10)

                user_data = get_user_data(user_id)
                if user_data:
                    entry_first_name.insert(0, user_data[0])
                    entry_last_name.insert(0, user_data[1])

            edit_button = tk.Button(user_info_frame, text="Редактировать", command=lambda: edit_user(user_id),
                                    font=("Arial", 14))
            edit_button.grid(row=4, column=0, sticky='nw', pady=10)

    display_user_data(user_id)

    data_display_frame = tk.Frame(main_window, bd=2, relief=tk.GROOVE)
    data_display_frame.grid(row=2, column=0, columnspan=2, pady=10, padx=10, sticky='nsew')

    main_window.rowconfigure(2, weight=1)
    main_window.columnconfigure(0, weight=1)



    main_window.mainloop()


root = tk.Tk()
root.title("Вход/Регистрация")
root.geometry('400x300')

button_style = {"font": ("Arial", 14), "width": 20, "height": 2}

button_frame = tk.Frame(root)
button_frame.pack(pady=50)

user_login = tk.Button(button_frame, text="Войти", command=open_login_window, **button_style)
user_login.pack(side=tk.TOP, pady=10)

user_register = tk.Button(button_frame, text="Зарегистрироваться", command=open_register_window, **button_style)
user_register.pack(side=tk.TOP, pady=10)

root.mainloop()

root.mainloop()
