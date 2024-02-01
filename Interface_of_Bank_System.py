import threading
import tkinter as tk
from tkinter import messagebox
import psycopg2
from tkinter import ttk
import random
from config import *
import requests
from datetime import date
from PySide6.QtWidgets import QApplication, QMainWindow, QFrame, QGridLayout
from PySide6.QtWebEngineWidgets import QWebEngineView
from PySide6.QtCore import QUrl
import sys


def create_connection():
    conn = psycopg2.connect(host=host, user=user, password=password, dbname=db_name, client_encoding='UTF-8')
    return conn


def update_frame_title(data_display_frame, title):
    for widget in data_display_frame.winfo_children():
        if isinstance(widget, tk.Label):
            widget.destroy()

    title_label = tk.Label(data_display_frame, text=title, font=("Arial", 14))
    title_label.grid(row=0, column=0, columnspan=2, pady=(0, 5))


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


def show_payment_history(user_id, data_display_frame, title):
    try:
        update_frame_title(data_display_frame, title)

        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT service, payment_date, paument_sum FROM paymenthistory WHERE user_id = %s",
                            (user_id,))
                result = cur.fetchall()

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


def show_payments(user_id):
    try:
        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT service FROM payments", (user_id,))
                result = cur.fetchall()

                payment_window = tk.Toplevel()
                payment_window.title("Список сервисов")

                tree = ttk.Treeview(payment_window, columns=("Service"), show="headings")
                tree.heading("Service", text="Сервис")

                for row in result:
                    tree.insert("", "end", values=row)

                tree.pack(expand=True, fill="both")

                amount_label = tk.Label(payment_window, text="Сумма:", font=("Arial", 14))
                amount_label.pack(pady=10)

                amount_entry = tk.Entry(payment_window, font=("Arial", 14))
                amount_entry.pack(pady=10)

                pay_button = tk.Button(payment_window, text="Оплатить",
                                       command=lambda: make_payment(user_id, amount_entry.get(), tree, payment_window),
                                       font=("Arial", 14))
                pay_button.pack(pady=20)

    except psycopg2.Error as er:
        print(f"Error in {er}")


def make_payment(user_id, amount, tree, payment_window):
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
                    return 0  # Возвращаем 0 в случае ошибки или если пользователя не существует
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


def apply_for_credit():
    messagebox.showinfo("Кредит", "Вы успешно подали заявку на кредит!")


def show_user_loans(user_id, data_display_frame, title):
    try:
        update_frame_title(data_display_frame, title)

        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT interest, term, credit_sum FROM loans WHERE loan_Id = %s", (user_id,))
                result = cur.fetchall()

                tree = ttk.Treeview(data_display_frame, columns=["Interest", "Term", "Credit Sum"], show="headings")
                tree.heading("Interest", text="Процентная ставка")
                tree.heading("Term", text="Срок")
                tree.heading("Credit Sum", text="Сумма кредита")

                tree.grid(row=1, column=0, sticky="nsew")
                data_display_frame.rowconfigure(1, weight=1)
                data_display_frame.columnconfigure(0, weight=1)

                for row in result:
                    tree.insert("", "end", values=row)

    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось получить данные о кредитах: {e}")


def show_currency_rates(data_display_frame, title):
    try:
        update_frame_title(data_display_frame, title)

        api_url = "https://api.exchangerate-api.com/v4/latest/KZT"
        response = requests.get(api_url)
        response.raise_for_status()
        data = response.json()

        usd_to_kzt_rate = round(1 / data["rates"]["USD"], 1)
        eur_to_kzt_rate = round(1 / data["rates"]["EUR"], 2)
        rub_to_kzt_rate = round(1 / data["rates"]["RUB"], 2)

        currency_rates = [
            ("Доллар", usd_to_kzt_rate),
            ("Евро", eur_to_kzt_rate),
            ("Рубль", rub_to_kzt_rate)
        ]

        tree = ttk.Treeview(data_display_frame, columns=("Currency", "Rate"), show="headings")
        tree.heading("Currency", text="Валюта")
        tree.heading("Rate", text="Курс")

        tree.grid(row=1, column=0, sticky="nsew")
        data_display_frame.rowconfigure(1, weight=1)
        data_display_frame.columnconfigure(0, weight=1)

        for currency, rate in currency_rates:
            tree.insert("", "end", values=(currency, rate))

    except Exception as e:
        messagebox.showerror("Ошибка", f"Не удалось получить курсы валют: {e}")


def apply_for_insurance_policy():
    messagebox.showinfo("Страховой полис", "Вы успешно подали заявку на страховой полис!")


def show_insurance_policies(user_id, data_display_frame, title):
    try:
        update_frame_title(data_display_frame, title)

        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT policy_type, policy_sum FROM insurancepolicies WHERE policy_id = %s", (user_id,))
                res = cur.fetchall()

                tree = ttk.Treeview(data_display_frame, columns=("Policy Type", "Policy Sum"), show="headings")
                tree.heading("Policy Type", text="Тип полиса")
                tree.heading("Policy Sum", text="Сумма полиса")

                tree.grid(row=1, column=0, sticky="nsew")
                data_display_frame.rowconfigure(1, weight=1)
                data_display_frame.columnconfigure(0, weight=1)

                for row in res:
                    tree.insert("", "end", values=row)

    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось получить данные о страховых полисах: {e}")


def show_branches_data(data_display_frame, title):
    try:
        update_frame_title(data_display_frame, title)

        with create_connection() as connection:
            with connection.cursor() as cur:
                cur.execute("SELECT b.branch_name, b.branch_adress, city FROM branches as b")
                result = cur.fetchall()

                tree = ttk.Treeview(data_display_frame, columns=("Branch Name", "Branch Address", "City"), show="headings")
                tree.heading("Branch Name", text="Название филиала")
                tree.heading("Branch Address", text="Адрес филиала")
                tree.heading("City", text="Город")

                tree.grid(row=1, column=0, sticky="nsew")
                data_display_frame.rowconfigure(1, weight=1)
                data_display_frame.columnconfigure(0, weight=1)
                for row in result:
                    tree.insert("", "end", values=row)

    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось получить данные о филиалах: {e}")


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

    label_username = tk.Label(login_window, text="ИИН:", font=("Arial", 14))
    label_username.pack(pady=10)
    entry_username = tk.Entry(login_window, font=("Arial", 14))
    entry_username.pack()

    label_password = tk.Label(login_window, text="Пароль:", font=("Arial", 14))
    label_password.pack(pady=10)
    entry_password = tk.Entry(login_window, show="*", font=("Arial", 14))
    entry_password.pack()

    btn_login = tk.Button(login_window, text="Войти", command=lambda: login(entry_username.get(), entry_password.get()),
                          font=("Arial", 14))
    btn_login.pack(pady=20)


def open_register_window():
    def register(first_name, last_name, iin, password):
        try:
            with create_connection() as connection:

                with connection.cursor() as cur:
                    cur.execute("INSERT INTO users (first_name, last_name, iin, password) VALUES (%s, %s, %s, "
                                "%s) RETURNING user_id", (first_name, last_name, iin, password))
                    connection.commit()
                    user_id = cur.fetchone()[0]
                    messagebox.showinfo("Успех", "Регистрация прошла успешно!")
                    register_window.destroy()
                    show_main_window(user_id)

        except psycopg2.Error as er:
            messagebox.showerror("Ошибка", f"Ошибка при регистрации: {er}")

    register_window = tk.Toplevel(root)
    register_window.title("Регистрация")

    label_entry_userfirstname = tk.Label(register_window, text="Имя:", font=("Arial", 14))
    label_entry_userfirstname.pack(pady=10)
    entry_userfirstname = tk.Entry(register_window, font=("Arial", 14))
    entry_userfirstname.pack()

    label_entry_lastname = tk.Label(register_window, text="фамилия:", font=("Arial", 14))
    label_entry_lastname.pack(pady=10)
    entry_lastanme = tk.Entry(register_window, font=("Arial", 14))
    entry_lastanme.pack()

    label_username = tk.Label(register_window, text="ИИН:", font=("Arial", 14))
    label_username.pack(pady=10)
    entry_username = tk.Entry(register_window, font=("Arial", 14))
    entry_username.pack()

    label_password = tk.Label(register_window, text="Пароль:", font=("Arial", 14))
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


def open_credit_card(user_id):
    if card_exists_for_user(user_id):
        root = tk.Tk()
        root.withdraw()  #
        result = messagebox.askquestion("Уже есть карта", "У вас уже есть карта. Открыть новую карту?")
        if result == "yes":
            update_existing_credit_card(user_id)
        else:
            messagebox.showinfo("Отмена", "Оставлена текущая карта.")

    else:
        create_new_credit_card(user_id)


def create_new_credit_card(user_id):
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
    except psycopg2.Error as e:
        messagebox.showerror("Ошибка", f"Не удалось открыть карту: {e}")


def update_existing_credit_card(user_id):
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

    options_menu = tk.Menu(menubar, tearoff=0)
    menubar.add_cascade(label="Кредиты", menu=options_menu)

    options_menu.add_command(label="Текущие кредиты",
                             command=lambda: show_user_loans(user_id, data_display_frame, "Текщие кредиты"))
    options_menu.add_command(label="Заявка на кредит", command=apply_for_credit)

    insurance_menu = tk.Menu(menubar, tearoff=0)
    menubar.add_cascade(label="Страховые полисы", menu=insurance_menu)
    insurance_menu.add_command(label="Просмотр текущих полисов",
                               command=lambda: show_insurance_policies(user_id, data_display_frame,
                                                                       "Текущие полисы"))
    insurance_menu.add_command(label="Подать заявку на страховой полис", command=apply_for_insurance_policy)

    payment_menu = tk.Menu(menubar, tearoff=0)
    menubar.add_cascade(label="Платежи", menu=payment_menu)
    payment_menu.add_command(label="История платежей",
                             command=lambda: show_payment_history(user_id, data_display_frame,
                                                                  "История платежей"))
    payment_menu.add_command(label="Платежи", command=lambda: show_payments(user_id))

    credit_menu = tk.Menu(menubar, tearoff=0)
    menubar.add_cascade(label="Счета", menu=credit_menu)

    credit_menu.add_command(label="Открыть счет",
                            command=lambda: show_user_loans(user_id, data_display_frame, "Текщие кредиты"))
    credit_menu.add_command(label="Текущие счета", command=apply_for_credit)

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

            def edit_user(user_id):
                def save_changes(user_id):
                    new_first_name = entry_first_name.get()
                    new_last_name = entry_last_name.get()

                    try:
                        with create_connection() as connection:
                            with connection.cursor() as cur:
                                cur.execute("UPDATE users SET first_name = %s, last_name = %s WHERE user_id = %s",
                                            (new_first_name, new_last_name, user_id))
                                messagebox.showinfo("Успех", "Данные пользователя успешно обновлены!")
                                edit_window.destroy()
                                display_user_data(user_id)
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

    buttons_frame = tk.Frame(main_window)
    buttons_frame.grid(row=0, column=1, sticky='ne', padx=10, pady=10)

    button_width = 20

    accounts_button = tk.Button(buttons_frame, text="Открыть карту", command=lambda: open_credit_card(user_id),
                                font=button_font,
                                width=button_width)
    accounts_button.grid(row=0, column=2, sticky="ne", padx=10, pady=5)

    branches_button = tk.Button(buttons_frame, text="Филиалы",
                                command=lambda: show_branches_data(data_display_frame, title="Филиалы"),
                                font=button_font, width=button_width)
    branches_button.grid(row=2, column=2, sticky="ne", padx=10, pady=5)

    currency_button = tk.Button(buttons_frame, text="Курсы валют",
                                command=lambda: show_currency_rates(data_display_frame, title="Курсы волют"),
                                font=button_font,
                                width=button_width)
    currency_button.grid(row=3, column=2, sticky="ne", padx=10, pady=5)

    currency_label = tk.Label(main_window, font=("Arial", 12))
    currency_label.grid(row=1, column=0, sticky="se", padx=10, pady=10)

    data_display_frame = tk.Frame(main_window, bd=2, relief=tk.GROOVE)
    data_display_frame.grid(row=2, column=0, columnspan=2, pady=10, padx=10, sticky='nsew')

    main_window.rowconfigure(2, weight=1)
    main_window.columnconfigure(0, weight=1)

    main_window.mainloop()


root = tk.Tk()
root.title("Вход/Регистрация")
root.geometry('400x300')

user_login = tk.Button(root, text="Войти", command=open_login_window, font=("Arial", 14))
user_login.pack(pady=20)

user_register = tk.Button(root, text="Зарегистрироваться", command=open_register_window, font=("Arial", 14))
user_register.pack(pady=20)

root.mainloop()

root.mainloop()
