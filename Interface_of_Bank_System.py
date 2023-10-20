import tkinter as tk


def show_users():
    # Реализация отображения списка пользователей
    pass


def show_accounts():
    # Реализация отображения списка счетов
    pass


def show_payments_history():
    # Реализация отображения истории платежей
    pass


def show_payments():
    # Реализация функции для выполнения платежей
    pass


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

# Создаем кнопки для каждой функции
users_button = tk.Button(root, text="Пользователи", command=show_users)
users_button.pack(pady=10)
accounts_button = tk.Button(root, text="Счета", command=show_accounts)
payments_history_button = tk.Button(root, text="История платежей", command=show_payments_history)
payments_button = tk.Button(root, text="Платежи", command=show_payments)
credit_button = tk.Button(root, text="Заявка на кредит", command=apply_for_credit)
user_credits_button = tk.Button(root, text="Текущие кредиты", command=show_user_credits)
currency_rates_button = tk.Button(root, text="Курсы валют", command=show_currency_rates)
insurance_button = tk.Button(root, text="Заявка на страховой полис", command=apply_for_insurance_policy)
insurance_policies_button = tk.Button(root, text="Текущие полисы", command=show_insurance_policies)
branches_button = tk.Button(root, text="Филиалы", command=show_branches)

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
