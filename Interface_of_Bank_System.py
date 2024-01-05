import psycopg2
import random
import tkinter as tk
from config import host, user, password, db_name


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

            # Добавляем полосу прокрутки
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


def show_payments_history():
    try:
        with psycopg2.connect(host=host, user=user, password=password, database=db_name) as connection:
            print("Соединение прошло успешно.")

        with connection.cursor() as cur:
            cur.execute("SELECT * FROM paymenthistory")
            result = cur.fetchall()
            for row in result:
                print(row)

    except psycopg2.Error as er:
        print(f"Error in {er}")


def show_payments():
    try:
        with psycopg2.connect(host=host, user=user, password=password, database=db_name) as connection:
            print("Соединение прошло успешно.")

        with connection.cursor() as cur:
            cur.execute("SELECT * FROM payments")
            result = cur.fetchall()
            for row in result:
                print(row)

    except psycopg2.Error as er:
        print(f"Error in {er}")


def apply_for_credit():
    # Реализация заявки на кредит
    pass


def show_user_credits():
    # Реализация отображения текущих кредитов у пользователя
    pass


def show_currency_rates():
    # Реализация отображения курсов валют
    pass


def apply_for_insurance_policy():
    # Реализация заявки на страховой полис
    pass


def show_insurance_policies():
    # Реализация отображения текущих страховых полисов
    pass


def show_branches():
    # Реализация отображения списка филиалов
    pass


root = tk.Tk()
root.title("Банковская система")
root.geometry('750x750')

# anchor: NE = TopRight, N = TopCenter, NW = TopLeft, W = LeftCenter, E = RightCenter, Sw = BottomLeft S =
# BottomCenter SE = BottomRight

# Sign in
user_login = tk.Button(root, text="Sign up")
user_login.pack(anchor="ne", padx=10, pady=10, side="right")

# Sign up
user_register = tk.Button(root, text="Sign in")
user_register.pack(anchor="ne", padx=10, pady=10, side="right")

# User_Profile
users_button = tk.Button(root, text="Пользователи", command=show_users)
users_button.pack(padx=10, pady=10)

# Account
accounts_button = tk.Button(root, text="Счета", command=show_accounts)
accounts_button.pack(padx=10, pady=10)

# Payment_history
payments_history_button = tk.Button(root, text="История платежей", command=show_payments_history)
payments_history_button.pack(padx=10, pady=10)

# Payment
payments_button = tk.Button(root, text="Платежи", command=show_payments)
payments_button.pack(padx=10, pady=10)

# Loans_Applications
credit_button = tk.Button(root, text="Заявка на кредит", command=apply_for_credit)
credit_button.pack(padx=10, pady=10)

# Loans
user_credits_button = tk.Button(root, text="Текущие кредиты", command=show_user_credits)
user_credits_button.pack(padx=10, pady=10)

# Currency_rate
currency_rates_button = tk.Button(root, text="Курсы валют", command=show_currency_rates)
currency_rates_button.pack(padx=10, pady=10)

# Insurance
insurance_button = tk.Button(root, text="Заявка на страховой полис", command=apply_for_insurance_policy)
insurance_button.pack(padx=10, pady=10)

# Insurance_policies
insurance_policies_button = tk.Button(root, text="Текущие полисы", command=show_insurance_policies)
insurance_policies_button.pack(padx=10, pady=10)

# Branches
branches_button = tk.Button(root, text="Филиалы", command=show_branches)
branches_button.pack(padx=10, pady=10)

# Размещаем кнопки на окне
users_button.pack()
accounts_button.pack()
payments_history_button.pack()
payments_button.pack()
credit_button.pack()
user_credits_button.pack()
currency_rates_button.pack()
insurance_button.pack()
insurance_policies_button.pack()
branches_button.pack()

root.mainloop()
