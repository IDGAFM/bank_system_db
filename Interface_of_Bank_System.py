import tkinter as tk
from tkinter import messagebox, Toplevel
import psycopg2
import random
from config import *
import requests

# Функция генерации случайного ИИН
def generate_random_inn():
    year = str(random.randint(0, 99)).zfill(2)
    month = str(random.randint(1, 12)).zfill(2)
    day = str(random.randint(1, 31)).zfill(2)
    return year + month + day + ''.join([str(random.randint(0, 9)) for _ in range(6)])


# Функция для отображения окна с данными о пользователях
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


# Функция для отображения окна с данными о счетах
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


# Функция для заявки на кредит
def apply_for_credit():
    messagebox.showinfo("Кредит", "Вы успешно подали заявку на кредит!")


# Функция для отображения текущих кредитов у пользователя
def show_user_credits():
    # Реализация отображения текущих кредитов у пользователя
    pass


# Функция для отображения курсов валют

def show_currency_rates():

    try:
        api_url = "https://api.exchangerate-api.com/v4/latest/KZT"
        response = requests.get(api_url)
        response.raise_for_status()  # Raise an HTTPError for bad responses
        data = response.json()

        usd_to_kzt_rate = round(1 / data["rates"]["USD"], 1)
        eur_to_kzt_rate = round(1 / data["rates"]["EUR"], 2)
        rub_to_kzt_rate = round(1 / data["rates"]["RUB"], 2)

        # Создание нового окна для отображения курсов валют
        currency_rates_window = Toplevel()
        currency_rates_window.title("Курсы валют")

        # Отображение полученных данных
        tk.Label(currency_rates_window, text=f"USD/KZT: {usd_to_kzt_rate}").pack()
        tk.Label(currency_rates_window, text=f"EUR/KZT: {eur_to_kzt_rate}").pack()
        tk.Label(currency_rates_window, text=f"RUB/KZT: {rub_to_kzt_rate}").pack()

    except Exception as e:
        messagebox.showerror("Ошибка", f"Не удалось получить курсы валют: {e}")


# Функция для заявки на страховой полис
def apply_for_insurance_policy():
    messagebox.showinfo("Страховой полис", "Вы успешно подали заявку на страховой полис!")


# Функция для отображения текущих страховых полисов
def show_insurance_policies():
    messagebox.showinfo("Страховые полисы", "Отображение текущих страховых полисов")


# Функция для отображения списка филиалов
def show_branches():
    # Реализация отображения списка филиалов
    pass


# Функция для отображения окна входа
def open_login_window():
    login_window = tk.Toplevel(root)
    login_window.title("Вход")

    label_username = tk.Label(login_window, text="Имя пользователя:", font=("Arial", 14))
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

    def login(username, password):
        messagebox.showinfo("Успех", "Вы успешно вошли в систему!")
        login_window.destroy()  # Закрытие окна входа,
        show_main_window()


def open_register_window():
    register_window = tk.Toplevel(root)
    register_window.title("Регистрация")

    label_username = tk.Label(register_window, text="Имя пользователя:", font=("Arial", 14))
    label_username.pack(pady=10)
    entry_username = tk.Entry(register_window, font=("Arial", 14))
    entry_username.pack()

    label_password = tk.Label(register_window, text="Пароль:", font=("Arial", 14))
    label_password.pack(pady=10)
    entry_password = tk.Entry(register_window, show="*", font=("Arial", 14))
    entry_password.pack()

    btn_register = tk.Button(register_window, text="Зарегистрироваться",
                             command=lambda: register(entry_username.get(), entry_password.get()), font=("Arial", 14))
    btn_register.pack(pady=20)

    def register(username, password):
        messagebox.showinfo("Успех", "Регистрация прошла успешно!")
        register_window.destroy()
        show_main_window()


def show_main_window():
    root.withdraw()  # Скрываем окно входа/регистрации
    main_window = tk.Tk()  # Создаем новое главное окно
    main_window.title("Банковская система")
    main_window.geometry('750x750')

    # Создаем меню в главном окне
    menubar = tk.Menu(main_window)
    main_window.config(menu=menubar)

    # Добавляем пункты меню
    options_menu = tk.Menu(menubar, tearoff=0)
    menubar.add_cascade(label="Кредиты", menu=options_menu)

    # Добавляем команды в подменю
    options_menu.add_command(label="Текущие кредиты", command=show_currency_rates)
    options_menu.add_command(label="Заявка на кредит", command=apply_for_credit)

    # Добавляем пункты меню для страховых полисов
    insurance_menu = tk.Menu(menubar, tearoff=0)
    menubar.add_cascade(label="Страховые полисы", menu=insurance_menu)
    insurance_menu.add_command(label="Просмотр текущих полисов", command=show_insurance_policies)
    insurance_menu.add_command(label="Подать заявку на страховой полис", command=apply_for_insurance_policy)

    payment_menu = tk.Menu(menubar, tearoff=0)
    menubar.add_cascade(label="Платежи", menu=payment_menu)
    payment_menu.add_command(label="История платежей", command=show_payments_history)
    payment_menu.add_command(label="Платежи", command=show_payments_history)


    # Создаем кнопки в главном окне
    users_button = tk.Button(main_window, text="Пользователи", command=show_users, font=("Arial", 14))
    accounts_button = tk.Button(main_window, text="Счета", command=show_accounts, font=("Arial", 14))
    currency_rates_button = tk.Button(main_window, text="Курсы валют", command=show_currency_rates, font=("Arial", 14))

    branches_button = tk.Button(main_window, text="Филиалы", command=show_branches, font=("Arial", 14))

    users_button.pack(pady=10)
    accounts_button.pack(pady=10)
    currency_rates_button.pack(pady=10)
    branches_button.pack(pady=10)

    main_window.mainloop()


root = tk.Tk()
root.title("Вход/Регистрация")
root.geometry('400x300')

# Sign in
user_login = tk.Button(root, text="Sign in", command=open_login_window, font=("Arial", 14))
user_login.pack(pady=20)

# Sign up
user_register = tk.Button(root, text="Sign up", command=open_register_window, font=("Arial", 14))
user_register.pack(pady=20)

root.mainloop()
