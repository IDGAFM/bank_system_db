PGDMP                          |            bank_system_v3    15.4    15.4 ^    k           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            l           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            m           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            n           1262    58065    bank_system_v3    DATABASE     �   CREATE DATABASE bank_system_v3 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Kazakhstan.1251';
    DROP DATABASE bank_system_v3;
                postgres    false            �            1259    58066    account    TABLE     �   CREATE TABLE public.account (
    account_id integer NOT NULL,
    branch_id integer,
    user_id integer,
    balance integer,
    type_account character varying(13)
);
    DROP TABLE public.account;
       public         heap    postgres    false            �            1259    58069    account_account_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.account_account_id_seq;
       public          postgres    false    214            o           0    0    account_account_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.account_account_id_seq OWNED BY public.account.account_id;
          public          postgres    false    215            �            1259    58070    branches    TABLE     �   CREATE TABLE public.branches (
    branch_id integer NOT NULL,
    branch_name character varying(50),
    branch_adress character varying(15),
    city character varying(13)
);
    DROP TABLE public.branches;
       public         heap    postgres    false            �            1259    58073    branches_branch_id_seq    SEQUENCE     �   CREATE SEQUENCE public.branches_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.branches_branch_id_seq;
       public          postgres    false    216            p           0    0    branches_branch_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.branches_branch_id_seq OWNED BY public.branches.branch_id;
          public          postgres    false    217            �            1259    58074    creditcards    TABLE     �   CREATE TABLE public.creditcards (
    card_id integer NOT NULL,
    user_id integer,
    card_num character varying(50),
    validity date,
    remainder integer
);
    DROP TABLE public.creditcards;
       public         heap    postgres    false            �            1259    58077    creditcards_card_id_seq    SEQUENCE     �   CREATE SEQUENCE public.creditcards_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.creditcards_card_id_seq;
       public          postgres    false    218            q           0    0    creditcards_card_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.creditcards_card_id_seq OWNED BY public.creditcards.card_id;
          public          postgres    false    219            �            1259    58078    insuranceclaims    TABLE     �   CREATE TABLE public.insuranceclaims (
    claim_id integer NOT NULL,
    policy_id integer,
    payment_amount integer,
    date_payment date
);
 #   DROP TABLE public.insuranceclaims;
       public         heap    postgres    false            �            1259    58081    insuranceclaims_claim_id_seq    SEQUENCE     �   CREATE SEQUENCE public.insuranceclaims_claim_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.insuranceclaims_claim_id_seq;
       public          postgres    false    220            r           0    0    insuranceclaims_claim_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.insuranceclaims_claim_id_seq OWNED BY public.insuranceclaims.claim_id;
          public          postgres    false    221            �            1259    58082    insurancepolicies    TABLE     �   CREATE TABLE public.insurancepolicies (
    policy_id integer NOT NULL,
    user_id integer,
    policy_type character varying(21),
    policy_sum numeric(8,3)
);
 %   DROP TABLE public.insurancepolicies;
       public         heap    postgres    false            �            1259    58085    insurancepolicies_policy_id_seq    SEQUENCE     �   CREATE SEQUENCE public.insurancepolicies_policy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.insurancepolicies_policy_id_seq;
       public          postgres    false    222            s           0    0    insurancepolicies_policy_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.insurancepolicies_policy_id_seq OWNED BY public.insurancepolicies.policy_id;
          public          postgres    false    223            �            1259    58086    loanapplications    TABLE     �   CREATE TABLE public.loanapplications (
    application_id integer NOT NULL,
    user_id integer,
    amount_requested integer,
    status character varying(19)
);
 $   DROP TABLE public.loanapplications;
       public         heap    postgres    false            �            1259    58089 #   loanapplications_application_id_seq    SEQUENCE     �   CREATE SEQUENCE public.loanapplications_application_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.loanapplications_application_id_seq;
       public          postgres    false    224            t           0    0 #   loanapplications_application_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.loanapplications_application_id_seq OWNED BY public.loanapplications.application_id;
          public          postgres    false    225            �            1259    58090    loans    TABLE     �   CREATE TABLE public.loans (
    loan_id integer NOT NULL,
    application_id integer,
    interest integer,
    term date,
    credit_sum numeric(8,3)
);
    DROP TABLE public.loans;
       public         heap    postgres    false            �            1259    58093    loans_loan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.loans_loan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.loans_loan_id_seq;
       public          postgres    false    226            u           0    0    loans_loan_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.loans_loan_id_seq OWNED BY public.loans.loan_id;
          public          postgres    false    227            �            1259    58094    paymenthistory    TABLE     �   CREATE TABLE public.paymenthistory (
    history_id integer NOT NULL,
    payment_id integer,
    loan_id integer,
    service character varying(50),
    paument_sum integer,
    payment_date date,
    user_id integer
);
 "   DROP TABLE public.paymenthistory;
       public         heap    postgres    false            �            1259    58097    paymenthistory_history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.paymenthistory_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.paymenthistory_history_id_seq;
       public          postgres    false    228            v           0    0    paymenthistory_history_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.paymenthistory_history_id_seq OWNED BY public.paymenthistory.history_id;
          public          postgres    false    229            �            1259    58098    payments    TABLE     z   CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    card_id integer,
    service character varying(50)
);
    DROP TABLE public.payments;
       public         heap    postgres    false            �            1259    58101    payments_payment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.payments_payment_id_seq;
       public          postgres    false    230            w           0    0    payments_payment_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;
          public          postgres    false    231            �            1259    58102    transactions    TABLE     �   CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    sender_id integer,
    recipient_id integer,
    sum integer,
    date_time_tr date
);
     DROP TABLE public.transactions;
       public         heap    postgres    false            �            1259    58105    transactions_transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.transactions_transaction_id_seq;
       public          postgres    false    232            x           0    0    transactions_transaction_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;
          public          postgres    false    233            �            1259    58106    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    iin character varying(50),
    password character varying(50),
    registration_date date
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    58109    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    234            y           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    235            �           2604    58110    account account_id    DEFAULT     x   ALTER TABLE ONLY public.account ALTER COLUMN account_id SET DEFAULT nextval('public.account_account_id_seq'::regclass);
 A   ALTER TABLE public.account ALTER COLUMN account_id DROP DEFAULT;
       public          postgres    false    215    214            �           2604    58111    branches branch_id    DEFAULT     x   ALTER TABLE ONLY public.branches ALTER COLUMN branch_id SET DEFAULT nextval('public.branches_branch_id_seq'::regclass);
 A   ALTER TABLE public.branches ALTER COLUMN branch_id DROP DEFAULT;
       public          postgres    false    217    216            �           2604    58112    creditcards card_id    DEFAULT     z   ALTER TABLE ONLY public.creditcards ALTER COLUMN card_id SET DEFAULT nextval('public.creditcards_card_id_seq'::regclass);
 B   ALTER TABLE public.creditcards ALTER COLUMN card_id DROP DEFAULT;
       public          postgres    false    219    218            �           2604    58113    insuranceclaims claim_id    DEFAULT     �   ALTER TABLE ONLY public.insuranceclaims ALTER COLUMN claim_id SET DEFAULT nextval('public.insuranceclaims_claim_id_seq'::regclass);
 G   ALTER TABLE public.insuranceclaims ALTER COLUMN claim_id DROP DEFAULT;
       public          postgres    false    221    220            �           2604    58114    insurancepolicies policy_id    DEFAULT     �   ALTER TABLE ONLY public.insurancepolicies ALTER COLUMN policy_id SET DEFAULT nextval('public.insurancepolicies_policy_id_seq'::regclass);
 J   ALTER TABLE public.insurancepolicies ALTER COLUMN policy_id DROP DEFAULT;
       public          postgres    false    223    222            �           2604    58115    loanapplications application_id    DEFAULT     �   ALTER TABLE ONLY public.loanapplications ALTER COLUMN application_id SET DEFAULT nextval('public.loanapplications_application_id_seq'::regclass);
 N   ALTER TABLE public.loanapplications ALTER COLUMN application_id DROP DEFAULT;
       public          postgres    false    225    224            �           2604    58116    loans loan_id    DEFAULT     n   ALTER TABLE ONLY public.loans ALTER COLUMN loan_id SET DEFAULT nextval('public.loans_loan_id_seq'::regclass);
 <   ALTER TABLE public.loans ALTER COLUMN loan_id DROP DEFAULT;
       public          postgres    false    227    226            �           2604    58117    paymenthistory history_id    DEFAULT     �   ALTER TABLE ONLY public.paymenthistory ALTER COLUMN history_id SET DEFAULT nextval('public.paymenthistory_history_id_seq'::regclass);
 H   ALTER TABLE public.paymenthistory ALTER COLUMN history_id DROP DEFAULT;
       public          postgres    false    229    228            �           2604    58118    payments payment_id    DEFAULT     z   ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);
 B   ALTER TABLE public.payments ALTER COLUMN payment_id DROP DEFAULT;
       public          postgres    false    231    230            �           2604    58119    transactions transaction_id    DEFAULT     �   ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);
 J   ALTER TABLE public.transactions ALTER COLUMN transaction_id DROP DEFAULT;
       public          postgres    false    233    232            �           2604    58120    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    235    234            S          0    58066    account 
   TABLE DATA           X   COPY public.account (account_id, branch_id, user_id, balance, type_account) FROM stdin;
    public          postgres    false    214   �o       U          0    58070    branches 
   TABLE DATA           O   COPY public.branches (branch_id, branch_name, branch_adress, city) FROM stdin;
    public          postgres    false    216   .s       W          0    58074    creditcards 
   TABLE DATA           V   COPY public.creditcards (card_id, user_id, card_num, validity, remainder) FROM stdin;
    public          postgres    false    218   �w       Y          0    58078    insuranceclaims 
   TABLE DATA           \   COPY public.insuranceclaims (claim_id, policy_id, payment_amount, date_payment) FROM stdin;
    public          postgres    false    220   [       [          0    58082    insurancepolicies 
   TABLE DATA           X   COPY public.insurancepolicies (policy_id, user_id, policy_type, policy_sum) FROM stdin;
    public          postgres    false    222   ��       ]          0    58086    loanapplications 
   TABLE DATA           ]   COPY public.loanapplications (application_id, user_id, amount_requested, status) FROM stdin;
    public          postgres    false    224   :�       _          0    58090    loans 
   TABLE DATA           T   COPY public.loans (loan_id, application_id, interest, term, credit_sum) FROM stdin;
    public          postgres    false    226   p�       a          0    58094    paymenthistory 
   TABLE DATA           v   COPY public.paymenthistory (history_id, payment_id, loan_id, service, paument_sum, payment_date, user_id) FROM stdin;
    public          postgres    false    228   H�       c          0    58098    payments 
   TABLE DATA           @   COPY public.payments (payment_id, card_id, service) FROM stdin;
    public          postgres    false    230   �       e          0    58102    transactions 
   TABLE DATA           b   COPY public.transactions (transaction_id, sender_id, recipient_id, sum, date_time_tr) FROM stdin;
    public          postgres    false    232   ɐ       g          0    58106    users 
   TABLE DATA           a   COPY public.users (user_id, first_name, last_name, iin, password, registration_date) FROM stdin;
    public          postgres    false    234   B�       z           0    0    account_account_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.account_account_id_seq', 100, true);
          public          postgres    false    215            {           0    0    branches_branch_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.branches_branch_id_seq', 100, true);
          public          postgres    false    217            |           0    0    creditcards_card_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.creditcards_card_id_seq', 100, true);
          public          postgres    false    219            }           0    0    insuranceclaims_claim_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.insuranceclaims_claim_id_seq', 100, true);
          public          postgres    false    221            ~           0    0    insurancepolicies_policy_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.insurancepolicies_policy_id_seq', 100, true);
          public          postgres    false    223                       0    0 #   loanapplications_application_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.loanapplications_application_id_seq', 100, true);
          public          postgres    false    225            �           0    0    loans_loan_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.loans_loan_id_seq', 100, true);
          public          postgres    false    227            �           0    0    paymenthistory_history_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.paymenthistory_history_id_seq', 101, true);
          public          postgres    false    229            �           0    0    payments_payment_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.payments_payment_id_seq', 96, true);
          public          postgres    false    231            �           0    0    transactions_transaction_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 100, true);
          public          postgres    false    233            �           0    0    users_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.users_user_id_seq', 101, true);
          public          postgres    false    235            �           2606    58122    account account_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (account_id);
 >   ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
       public            postgres    false    214            �           2606    58124    branches branches_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (branch_id);
 @   ALTER TABLE ONLY public.branches DROP CONSTRAINT branches_pkey;
       public            postgres    false    216            �           2606    58126    creditcards creditcards_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.creditcards
    ADD CONSTRAINT creditcards_pkey PRIMARY KEY (card_id);
 F   ALTER TABLE ONLY public.creditcards DROP CONSTRAINT creditcards_pkey;
       public            postgres    false    218            �           2606    58128 $   insuranceclaims insuranceclaims_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.insuranceclaims
    ADD CONSTRAINT insuranceclaims_pkey PRIMARY KEY (claim_id);
 N   ALTER TABLE ONLY public.insuranceclaims DROP CONSTRAINT insuranceclaims_pkey;
       public            postgres    false    220            �           2606    58130 (   insurancepolicies insurancepolicies_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.insurancepolicies
    ADD CONSTRAINT insurancepolicies_pkey PRIMARY KEY (policy_id);
 R   ALTER TABLE ONLY public.insurancepolicies DROP CONSTRAINT insurancepolicies_pkey;
       public            postgres    false    222            �           2606    58132 &   loanapplications loanapplications_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.loanapplications
    ADD CONSTRAINT loanapplications_pkey PRIMARY KEY (application_id);
 P   ALTER TABLE ONLY public.loanapplications DROP CONSTRAINT loanapplications_pkey;
       public            postgres    false    224            �           2606    58134    loans loans_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_pkey PRIMARY KEY (loan_id);
 :   ALTER TABLE ONLY public.loans DROP CONSTRAINT loans_pkey;
       public            postgres    false    226            �           2606    58136 "   paymenthistory paymenthistory_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT paymenthistory_pkey PRIMARY KEY (history_id);
 L   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT paymenthistory_pkey;
       public            postgres    false    228            �           2606    58138    payments payments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public            postgres    false    230            �           2606    58140    transactions transactions_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public            postgres    false    232            �           2606    58142    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    234            �           2606    58143    payments fk_card    FK CONSTRAINT     z   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_card FOREIGN KEY (card_id) REFERENCES public.creditcards(card_id);
 :   ALTER TABLE ONLY public.payments DROP CONSTRAINT fk_card;
       public          postgres    false    230    218    3239            �           2606    58148    account fk_employee    FK CONSTRAINT     ~   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fk_employee FOREIGN KEY (branch_id) REFERENCES public.branches(branch_id);
 =   ALTER TABLE ONLY public.account DROP CONSTRAINT fk_employee;
       public          postgres    false    216    3237    214            �           2606    58153    loans fk_loan    FK CONSTRAINT     �   ALTER TABLE ONLY public.loans
    ADD CONSTRAINT fk_loan FOREIGN KEY (application_id) REFERENCES public.loanapplications(application_id);
 7   ALTER TABLE ONLY public.loans DROP CONSTRAINT fk_loan;
       public          postgres    false    224    3245    226            �           2606    58158    loanapplications fk_loanapp    FK CONSTRAINT        ALTER TABLE ONLY public.loanapplications
    ADD CONSTRAINT fk_loanapp FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 E   ALTER TABLE ONLY public.loanapplications DROP CONSTRAINT fk_loanapp;
       public          postgres    false    3255    224    234            �           2606    58163    paymenthistory fk_payment    FK CONSTRAINT     �   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT fk_payment FOREIGN KEY (payment_id) REFERENCES public.payments(payment_id);
 C   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT fk_payment;
       public          postgres    false    230    228    3251            �           2606    58168     paymenthistory fk_paymenthistory    FK CONSTRAINT     �   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT fk_paymenthistory FOREIGN KEY (loan_id) REFERENCES public.loans(loan_id);
 J   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT fk_paymenthistory;
       public          postgres    false    3247    228    226            �           2606    58173    insuranceclaims fk_policy    FK CONSTRAINT     �   ALTER TABLE ONLY public.insuranceclaims
    ADD CONSTRAINT fk_policy FOREIGN KEY (policy_id) REFERENCES public.insurancepolicies(policy_id);
 C   ALTER TABLE ONLY public.insuranceclaims DROP CONSTRAINT fk_policy;
       public          postgres    false    220    222    3243            �           2606    58178    transactions fk_recipient    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_recipient FOREIGN KEY (recipient_id) REFERENCES public.account(account_id);
 C   ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_recipient;
       public          postgres    false    232    214    3235            �           2606    58183    transactions fk_sender    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_sender FOREIGN KEY (sender_id) REFERENCES public.account(account_id);
 @   ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_sender;
       public          postgres    false    3235    232    214            �           2606    58188    insurancepolicies fk_user    FK CONSTRAINT     }   ALTER TABLE ONLY public.insurancepolicies
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 C   ALTER TABLE ONLY public.insurancepolicies DROP CONSTRAINT fk_user;
       public          postgres    false    234    222    3255            �           2606    58193    creditcards fk_user    FK CONSTRAINT     w   ALTER TABLE ONLY public.creditcards
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 =   ALTER TABLE ONLY public.creditcards DROP CONSTRAINT fk_user;
       public          postgres    false    234    3255    218            �           2606    58198    account fk_user    FK CONSTRAINT     s   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 9   ALTER TABLE ONLY public.account DROP CONSTRAINT fk_user;
       public          postgres    false    234    214    3255            �           2606    58203    paymenthistory fk_user_id    FK CONSTRAINT     }   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 C   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT fk_user_id;
       public          postgres    false    234    228    3255            S   y  x�e�M�[K���b���6�V���v���Nd�e�9v�O$O\u���>����؜������q<�9�M��z�ݾ���nGyn�� ����������cW���Ra����s�\���ε<����6����2Q9�:�y؎�2\g�������������eIX���s�|���ŗے�B�l&c/��D�Љ��/_����#w�vk� ��ж�PÍ������#Bcr���yQ�9�d{EaH4�/�����k�QF�>�� �}� ���kF!H�@N�HK��%|s��h$��]&����0�^�a�{����	)�7eL��$�V~�6&\�~JQ�4��K�1a��1�5~7x��k*���o�W\8c��Dkd����Ee��)+�jaA-NB������|9jW	�>y�G-P;�J�h�&��~t-�3��!Un�h�@���C?�8��Z��T��<hhѶ�G����:rZXY�(�ᛔZ�vtuͪ5��boT�r��MȊA(*�����o'�Y�E���t�[!������0D
���Y4u(q-wkDZ�zfl�t���V�W��.�O[H
٦�fE��E��\�c�f�B0\�mks��p-�@��wG�Fڅ����waxS���9�]���zQC�F��0%x��[ <hU�^,�����l��j�e�v�����␂-0޺���X��(L�|�F� HӽM4��Q��g-�Da�p�x}<�D��JXV�9�R(xm�(�xΥ�eO��tS�Y�s�6� �ҞO6�d�ND./&�2�b�G&�5��
�����RQ�T�V��f����7�e3O�Gz<7�_���~��x<�L��;      U   �  x�}Wے�6}n� )|��K��N�L%��}�+��2�>-.3�2<���ӧO�#���fyx+��x��C�(ѭ�]���4���A&%BU�+�NT��!3F`���ҋ�A'�3�2|3��k�P����m3�AG�~#0�j��{�`Kdp���;��p�j��� ��Js�_�k.�Fɠ�gJ��`?s*��ҿ�,H\p�#w��2�F��L�ڤ�b�"����_}8�@1�1�֊�-�*��V�����VzD	Lw��~�/w�����[.��I��X.Q`D<0!���F�6�(�;G����fr�ۅ
�nPKV�H'AD%<tҸ`\^*[&����HF��}֜q�0�#	+��sQ�q��mя�ޔ��@��>�*���-z³Gf�� �ᦫ�]��#�f��z�Ys&�FYA\������ܢ�
މ�N�����*HF6��f�\���H{5N/J��%$p�������ZKR�ѳ�����d�$Ԯ�R�$�l:�\y��ʧ�G�5�Z�.h,	�PdL��
5��v��U���9-�ƒ*܇�T1�`�d��E焊����J�O�	��=��uiJ6aؾ�K3j���_���P���#-�����NI���i��q%%)x�R=������M��G�-ٛ2=�9b�b��zrt��%�,������c�z�O�/����,����8�,������vj�p�������䄨����c��eYc;��zκڋr��|D�,��'�2�#��1��f��J��)���s�s�	|�����c�� I���V��kN�kz�|��<����9����oڏ�`,Ɋ�aRG��%ա)�����'�@}Q�}M��)b�v���z8�"�'.8��cE
OH���Ԯ �E%{M�zG�$\F�w?(
�>��e�.JZ!Ė]Xx�ʊ����_��n5_���Nc��������[�{Z]�Lhֱ5���ej��a��C�e�;����y�So�}+o�ea����5��,��ýW�4/���xaEʥ��޸s�hSj���W��'�MuQEv�&�{KJ��m���S�*�]`��g�y���TWV�������Nx&�Tҳ�yv9���h�����qq&��=���:�      W   �  x�M��ql�For�-�@BI�&�8f	vwO���ئ�{	y����D�
��M�~t�����||����M�,���n�u�7��ԣU�{X���sm��y�[��z���{Y�i��7;v����ߌ�ӽd�^�K�d�m~���n����6��7�|Nʘ������?q�4���^�]�h�^Zo�����fSt�s��d��2�3��~���4e�iK-)���غ粟�g�,2{��#&f��p}�Sy��M"�`���+����O��/�m���4/_��o��+�Hboɩs�IQ�w����C}��`RF%F���O�,��eOˊ!7]�l-�Ž����gA[C*.�Ι\Lg~Q���%9�����F��E���Fi:$GՐ��MXo�b~X����6\l鄀PvE�/ovw�����C!KX2s^�CD�a���`T�P+�����h�Yjf�Ƌ�2]&G��]A|"!u������ߖ�h�Y���{=��)T4��^�6�^��j�ƶ�@�n�A�S>�W��_�j{�(�S��Bo���[��X}Ǉ�k	���/%b�.�Q>��3�C0��������i!Л�9� `"�B�����x�V�;�r�6��{�<�i���ɚ�NOjʟ��G���`�ں\-d�u7�����va.��B�M�a=\>�X���H�!��T��
3������^��Ӿ¢�s����trb�e��ڶh�����0xԝ� �`������h���-;F�`�?�جȎ�����@�is��`�0��իi�耀�0H��BD���.�	Kf�J�H���kP���֢�24�Wb��Ļd0�\M��W0�	����H�۫�`?%PLlrc��k���i���u��ۚ��D�1Y���@���2���mL$<�f�>H�@�~��#KƺzY�{��HU׺���xvx����^05�n�ï���ۜK�ukMR�I�X�u\>�eU�uq�Q�c�[��?Z� c\�&�.96��o-��F���X��6��p0�_�=��7`�hk��g{��V��?�I���0?\,A:��ƹ(�FLKp-�u���;!ă���X�L1� 3]�����B�bh�v劯@Ƃ���ق�nR`����-f'�������Ң����H�<��G� H`�>�S�M/0�7�;�(�$�1]��Ŏ� ����d�o ��R���
�'����_�@�l@�FdfU�t���� ��7cH.�Y���CIa`q%c=����T�����ۜW�D�d�����S��<�Pn!�4�V�q����,Q�z�f0�>��w���'68�wL����4���=����G^�`B�1[�B�e5�3����L�>&Wϯ��Z�L��PPׯFa�~���̗��L�7NF1����$.#���e�����q��m�.Z�0�Ne�;�#a�EE囘d\f�J�ݫ�9�=��y|9:����1�p#����ͬ��2�ul}�9:;e�G��o1��B�3��{����	�z�����ovt�2��l�Iu�a�9��y��"[aY�#�h�X�:L;� �_۠����(�cG�G����3(��E`����4y1�Afv��L�M���c���Vƾcn�#�a�C��s�1E�AF�i�]E��r}�2�GIA7F]dx���a�&<	�����T�� co��f~S�s�L�L�{H��s���=�q�M�clG	�L���̫o�F:ӻ ��~��fyڃ¨;/7�������裑{��u���D �J�~dݣ�Gx|���t�X��3�$}Ex	N�x���L�aH`�t�>�;É��ۼ0�e8���gc�f��)�������1�$q��      Y   9  x�U��$9E��\j��<��&�8C�]+�B�ýPM���'L�0�<���Q!�8Q�u�%;�у��L<��#�]�K�
�!�Qu�_�]�_�8���B�u�dG1N�ꌀp�3I�4��~�����p�-�@�G��Y� &�lA�!DTy���jDgS�Q� 5cՐ��ݐ.��aʙS���KsC��wN�!��4R�<���E
����������$nH=��;iH*m�Wm�q'����(�����|'�r�)iJď�d�t�k�2�4eZ�;�U���Q�"M��~)KaiJ�ev�ȸUi8��@��Y�ݔQ+#_xiJ��q��oJ_q�G��L��*�C�~j�u(I�Oh�6%��q�f�M�\ݔ�+�Oj�)�d�O��Z��tR�T:8������c	�8V�Z:�XMIR�������~��0��4��w�d�c�|�_���r]J�Ք�,�%�?��U�^�Y�����pV������j��N��V����6J��>��c�+�n%m����:�6���v����xWD��֐en����5$}%[�Z�T��CY��JSQ�ű�'a��Rl�<����W;�{/��7�,=�}�}�kʌu�}�W��%��U�sb�`ƭ�η�hƺ�g�c�/h���~2f'��W`��9�vܪ�;��.���lJE�߾cwҔȟ��B4eĵu���K�������o�@���;����u��fٔV~���
�_���v!�+"�t�e�-�Οٔ9~E9�Zۘ9Z&�g&�`L���� g�B>�d���$���}t�� �j^�3      [   �  x�}W�m\1<�U�A��M��\�p|H8N���� �j�|���|����������Ƿ��~<�~~yP��I����_/���?>_�^_½}��U|�x�����������k�r���t��bW򯧘�����w�ͭ�,)�[����"��o���8��-�k��]��k��-�6+1��I�
���\�R�� c�����ʦ����N8���ݍcxGa�c���y�j��kX\�y)��~����r����_I��J+>�e��/Np��m�{��-W�Jw���ui`�����J�ǁ��{p���T_�AR�{���}�'2f((�Ih�6G�IR�׮�*S�h�&աl�x�Rt`'������Ѓ|�l�U 7҉�*�!���~�����@.�� ���X�  �>�VY�L6�д'\�	=��0�DF���}��`}��� f%r1^��t���PE��+� ��/�Ԍ� *GV�K���j���k��&��A�(LVq�d��6��>QҲ�@%�1�Q���)|�g!�\�|Rs;�τ| .���Bq3��,�8X#��6���uoC�m�����AL(3rxBb���b�!ĄŢ6oQ�8���k0�'��_�)�M�!Ц��������S>
T���v\}8S�n��+Y(Z�7�X�M9�C ��b�p&P '�r�4az��<�r�=&�:p5<��Y�p!TE5�j9w���"o��S�#� F"��Z��Ht�+!|�l���L:k������sP�a�5!�́��q?����P|c1V�?�1A�J=MB;O�E}�%�º��I�p.�\�PO���4L���%�rW̮I=Q� ΀���� B�1���� b	\�������      ]   &  x���ۍd5���� T�KD���$@*b�+�p:#�U!Dy�~h�������>�� h�v������z��~w}�ޟ?_������F��_�\���/��/ן׷�˃_�
�"Ӳ��=��e}-����|��u��e���&�L�e��������|����_C�ݑ�n��;JBV�^�nɾwKqw��Ë:Yoi2�#l4Φ1��@I�q��D���E��RMd�C��8���.D3��
R���Ko��y*q���yz�;�]��.��U��nq����pG�Q�8�P�ܬQ�Wghɖ&th��R�X�!����c�rg����nT@|��a�\;U�u�of+�'#%;�����0�"�*
�q��ʩ�����K�\ۏˑtS�t��+�h��E��<�LNQ�M��5M����&��М�)�����=.�pz�J��'��`8e���E��+w]�cEo&hx��S�a6�^�0KXVj�����f�~�J���V04`�F���
�ꬉ��&]�Cx�f�i-���ɧ[��	'{�Ȅ�m����L�t��N$_$��v��������Cd�H����^L��4��{:����t����Q�i/��W�?n��*s8n�qwo����/'h�LA��:Ӹ��m��*�L$�y:��|k>�-�01>a����:�Wg�jnW��*��y�M`5a��,+�t~ne��5e�i����O�5�J�蜍Y@�45FS��oE��Y<^=y��7��
W�'x��V����<��������oe�8*      _   �  x�]V۱ø��z���G[��_�urmg'3�0G	���������~�.c��-KN�'���Y���� O0?��Z8�H,��}���:�e[���7i}�.oR٤�bb=��bD��Z��\HDF��h&��E�z	����T;�V?A��$��w��Z�~7��nk���A���pq����byC�(>D떠����� Xյ���h숺G��Dԟ��`�k�Yj7��x�E/��)��Ah���7�ėJ���̸~�=�"��bM[��Q?��b��c	=� ؚ�t��۷���d6�fCT�[s&����`�%Nr��+�b0���_ ����2|@��)�hI9��\%���Ad���Lr��3+1��%u�0�u���ڌn�Ϋ����k�R�!<� �@��ͨW��ԧ�vV!���T�G&��-՟N��T�Pi-��A ݥ�.�[�~h��cn�4~~��d�!J�[�v��K��Z.��f�;CSͶ����r�(��.��:��$NHnS�2~��}@���2�"ඁI07��i,p
Y��^f��Op,�{�(���L2�����OB����lqZ��!pa�ռKxY���?`�c�
cB�~
�Aq�
tm��rzT��Ck�D�M�������ˋ�|򦇁j�����ݠW�9m'D�����+1�>�_لD�f��q�d��xC6��A���b�0a%�|��ќ��R���-�>�%ϊ"xpЋ�s0.#�˖�
~M|�XKh�r������2�@Dn�m��=�B�P?���-�w��z�$c�T�x��g�nL��V�6�,ۡoRܮ�{�go�X��~-\��,���˻�,�J֍庒o��%?怤66�J��E�`� 7��R��!��,���������8R��q�cKg�WcمE��w&�pH�������k�|[�ǖr�6��~�C�|�T%�R� �b�SoA�Js��W���A?a�/��z�� `��U/*�q��q��|��=��c�r3�R��5���;�C|}�=JD�o��\Y�m�����ʁ�����wAv,�z��j�)��]�w����
���`a���Y�YC �Z���| Ļ��s��/�>�g4_�J�e!��n��������:�L��۔ �A�p��[ǯd)�-Ư�����1�yQ�6���<��ǲ����k�����      a   '   x�340�����Ԝ̼TNC#c �r��qqq ��      c   :  x�m�[v�0@�����Mt�1�!.0�LV_!&���OB>�ta/��_炟T{�&gG�{8�t�}�c��;�=����#;گ8��x����}�=����]��	�e�g{�m ���j[��8 ���ͧ���iM�_�����7����������	���؊@��'���F�����K}�8BE8��&~BE4��-SL8�Y�m�eq]�T�66a��@f?�܊E"�j������BU��v���xN(�Oo[�`���\^=��b�`�xlĉ���5lnjpⱫ��H8iq!D��T��3���	�	��qܜ�n~�3�Z��|<r��-��A��"���A1%?$ܪ��ބ*�!j���>"���`�ةI,�lɎ�w���p���Q�¹���<�'Un�|�h]ݴOB��JY�V�Ki�b�y�*��x�x%2W��,R*E�Se�Eՙ(�R��Y&����h�C-NQ��DѪE�\mJQ�S�Cs�E1��T?E1<Ŕ?���(Fe���b�SS��ԗS������S���G�Z���2�V�(�� �/�ތ6      e   i  x�U��u%1E׭\~�!�������.�l{�%���(��������! �@|0=�3�'B��O%"����H��ڷ�=�O�-�`" ��t���b$�� ��≤���~�#�[O���!�N+z��$��T�z�1����1 O$�_�� ���Օ�c��S|�I8c=!�5
t!�	lT��o�x����V��eݾ�`w2~BzBC�|���Pð��7y?�0�J6�SM#!��ߺ�iPeH�*�CMC�J5K�2lT�M��j�l&s���H#�-4?�0����͂+�|��7g#X�:7a��r�Y*5&��,����[�n)�-�����B=9|ʢ��Y��v�f(�"��d�Ep��.ݒ��[f)˽.e��^X�����[EC�����4�,2ޢ��� )��̜xY�.9�4�I�u)̅�[=xvO)N��u�(��h�~�d�u������M�X,u�\u��I"����k$���rcu��4�j�4&�kC�m";v6�kku��jY(�}yl������cC��O�c�Ƽ=���0\EiO�G�]sU����x礲�m�V�z��A��!�E-�fa��1ݪF����y�n#�a��E�q/lR1|ya]8��iX���&���z�a��1oo�e_k�7�q������5�3��!=���1���h&N�0��OEU�t��)gX�����~��hDʃ*4ʨ-�+Ђ��(w�_e��<��+���Ұ��r-�D���N�dX[�UW���ͧ�5B94��_⍓#�4`��Scm7w9���Lw�WY�0�Y'�j�ɞC�,9�e9��@���S9^����s����W      g   �  x�UXiS"M���/<�cuu���oo�`����a Y���f���o�F쇵����2���8�������~2�z-���)g�_�+�`�V�������&<F�Ҡ��j��7�n=$���f��B�t��Ogo�o]]͸H���/�8)$�:�m���ì�Fif�%+fk8?�}���	Rl�Q?cr2_�V�#�+�[D	IIw�_�{�;S��@N=Iv�xdHNZ�0%��|.}�I�����n����/�q�)r����\D!*��Z��6�2�I�L�]�==��V����Ҥ��)~����Ìh_qƤZ��q�/\>��m��p�3d'�r��ð7 h7>ǹ�"IUO���,'s����Գ�:�Ȇ��xL��V	J�����r��9�/<�c׾�(bZ�(�	��4&�}���J�\.6�ֶ�V�RR��	H5�#b���R͔��{��?wWj���w��ØG9�(�^���5�Jd��񌽝�����ٯ��}���ԃf��q-�2�L���Hj4���lk��?�Zy�4�Z�:t�C�m�� %L+� a�sC�3��\��Q�M���ߓ`�J��d�xv�!Q�gF+�-�$.���珳)�y7s��P��V�;J�a� ��׀�/,�.����L%�tR��=r���m��Hf�T����z�������h���~G��n���h�u;H�_��d��r�~�j�Bii0(��P��i�ZR
3`2���#��Y��dx,�
����yzn��㨃^��<N��J��n�nti?����:P�?�em��E;
�G	d1-���"A�_�U�i]���ZmR�����Q��a0 ��Z�� ��\9�?�N�/}3�G>@�)�����C ��~*�0�{v%�[]:��xt���6�U5�4|v�<M�~��~b��q*� ������shJ��G����S
�v��9�0r�ǌ���������8�D���KT
cG�BS�S/%/���yU��M��#??�� �B��G��0�bdR3of�L����	,��̠q���8�ЖQ ����Ya����i����,�`O�V�|
��h&��XjAy�z�b��o��ճ	���xLq����c�F�SI���$%=]Lm�N��pJ�I/MB���R OJ�WL	tɵ���^�^���\ %r1���R��,�t����Jנ0��m�g��%�}�q��<u�a'�@#��I������y��|��$�'N��8NF}b�p\�}�.��ty�y���?���J{����qs�K ��2(������\ܐIAx[� 
 ��0B�������ѕYind��	��k\��"GA#���M��(�d]�ٳ��mg�(�}x�� �)%i��"i"��R�b��N������1�p7E�Ӥ5	0o��[L?-�^�/r�S�RS�P$�F��	�t������S�����kv#��l��+AI%�5�d�8J��F,$ ��7��́��G/�1�;�`X�.Z��KaE���@\V������ˆ�'ը�U��#UІ�a%�⤹͗W����r)����u��b�x^�&�Q��)$ZO^�|���L����� �i��g���m�<�+��-������n��<�ыW*Pc/�];Xm�$�f�i<Χ�#6K�Z"���I5�o���@�t�Dr�zp`>���[�G�?I;q���vL���
�>�Mb������{Q��~��5r�P`���`�W��3
�욥DUe�iԚ�ƒ��	ُ��K������U��_4�'Ӈ�lyB�y(~/�;��3�`��@.W�Ċ6��R�&gm��m~1�7�I0I��c��7F�^�b�W�o�������t��'D�,�}R��,2��T��avO�J�����x{��!�u(��I��4:�	�+PcH@pg���p��3��I�d0�� �q��V-��q�������l�aa����p��UxP�"J��F�owQ�d������ygp|;�������7v=���Cx1l6I��<���py8��v۝��&�����T�����`���#%vQ�Ʈ�����@���;Q���}A��Uҗ��RS��[� ���X���z�'�hK��YO�vЅ��
Ԯ$���NUm^�jwS&�+T��n(mx�4j����0����p,������\}�`�È��[������ڀr�e����xy�i��n�2<��"L{M�� � A��
v�q���v��O5��:7���G1X�Yg����F/����E%�E��ᵡ�}��T��;����3��S+�K��PO hB�{�9(n�T����Re���x�������L<�49��P!�>� h�Vº��|��7b�j�s�wY���<s=�	�]��P��IX��bf���2'u�Ӓ�$u�8�bxY�W
c�S��P/�t~��4����=�:���8�Cê)Ҽ5��������js�:���Z7�S�<��Z�?�rP�p�a����DJ��k�]��ywkd�+Os�},F�F�M�5���w���6���:;��X.��c<z%��ܝ�]>�kJ[8Mh�ҷ��;����a+o�)A�u�v�:gb��}��w���*�o$�-�A�
Ƴۍ�Tu��r���4Il�un��|s[/^�LRQZ��4lF��.AiJq�I������~g�go���q��ِ�n7���L��6��X��@���R��گ�1�8���`Z���I<F7ta��Gj7�6�ZMO������u���3Н0n���0� ��A�,i�����S5	�@��A�A�Q=la���{�7,�ӥyX�:�͍�@���й��?JR ��團�i�x�V?i���ʼ!H�n�4������`��_����)n��1�������CE����-UH�/� �d-���q%юXi�v���c�����yF��8�7��.� ��AS�8����K3s.�·����FRؓF^.���8��C�iT�͇��+}o.����|�W�Q�H�q�
��%��]�#1������
A�U"�
��0�����ə���U����S#��ס�]5�A'�Nac8n6�%�]1S_X���1^��$'i�&`^���҄{�4F��N�6;�����0h&�++�}�~�j�(���.%�� ���k�j��0?pa%H_�Ƞ���Z�&}̛��	]���G2��,��+����>�X`�k�|�_T\�z��f@֭pz�ƚ8��Ew�x�_A?���D�j�����y�u=4�t	��u��A 
�Ղ�#�;�G��l0��ֳ
t���z�'\�A8�D^.e�֓b�k�m�j�<c ��	��i��,�p�3!��dx!�[j�w&fcZ�RϚ/�qy�L�[?T���a��}��|�vau2
г��*��tLvƙC26��|���5}�؟^�&������.�O�
z�0º:$_�z�sk�;��
��{2�&CB�V�j+����cfA     