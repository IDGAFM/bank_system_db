PGDMP      -                |            bank_bd    16.1    16.1 W               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    26049    bank_bd    DATABASE        CREATE DATABASE bank_bd WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Kazakhstan.1251';
    DROP DATABASE bank_bd;
                postgres    false            �            1259    26050    account    TABLE     �   CREATE TABLE public.account (
    account_id integer NOT NULL,
    branch_id integer,
    user_id integer,
    balance integer,
    type_account character varying(13)
);
    DROP TABLE public.account;
       public         heap    postgres    false            �            1259    26053    account_account_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.account_account_id_seq;
       public          postgres    false    215                       0    0    account_account_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.account_account_id_seq OWNED BY public.account.account_id;
          public          postgres    false    216            �            1259    26054    branches    TABLE     �   CREATE TABLE public.branches (
    branch_id integer NOT NULL,
    branch_name character varying(50),
    branch_adress character varying(15),
    city character varying(13)
);
    DROP TABLE public.branches;
       public         heap    postgres    false            �            1259    26057    branches_branch_id_seq    SEQUENCE     �   CREATE SEQUENCE public.branches_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.branches_branch_id_seq;
       public          postgres    false    217                       0    0    branches_branch_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.branches_branch_id_seq OWNED BY public.branches.branch_id;
          public          postgres    false    218            �            1259    26058    creditcards    TABLE     �   CREATE TABLE public.creditcards (
    card_id integer NOT NULL,
    user_id integer,
    card_num character varying(50),
    validity date,
    remainder integer
);
    DROP TABLE public.creditcards;
       public         heap    postgres    false            �            1259    26061    creditcards_card_id_seq    SEQUENCE     �   CREATE SEQUENCE public.creditcards_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.creditcards_card_id_seq;
       public          postgres    false    219                       0    0    creditcards_card_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.creditcards_card_id_seq OWNED BY public.creditcards.card_id;
          public          postgres    false    220            �            1259    26066    insurancepolicies    TABLE     �   CREATE TABLE public.insurancepolicies (
    policy_id integer NOT NULL,
    user_id integer,
    policy_type character varying(21),
    vehicle_num character varying(50),
    started_date date
);
 %   DROP TABLE public.insurancepolicies;
       public         heap    postgres    false            �            1259    26069    insurancepolicies_policy_id_seq    SEQUENCE     �   CREATE SEQUENCE public.insurancepolicies_policy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.insurancepolicies_policy_id_seq;
       public          postgres    false    221                       0    0    insurancepolicies_policy_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.insurancepolicies_policy_id_seq OWNED BY public.insurancepolicies.policy_id;
          public          postgres    false    222            �            1259    26070    loanapplications    TABLE     �   CREATE TABLE public.loanapplications (
    application_id integer NOT NULL,
    user_id integer,
    amount_requested integer,
    status character varying(19)
);
 $   DROP TABLE public.loanapplications;
       public         heap    postgres    false            �            1259    26073 #   loanapplications_application_id_seq    SEQUENCE     �   CREATE SEQUENCE public.loanapplications_application_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.loanapplications_application_id_seq;
       public          postgres    false    223                       0    0 #   loanapplications_application_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.loanapplications_application_id_seq OWNED BY public.loanapplications.application_id;
          public          postgres    false    224            �            1259    26074    loans    TABLE     �   CREATE TABLE public.loans (
    loan_id integer NOT NULL,
    application_id integer,
    interest integer,
    term date,
    credit_sum integer,
    user_id integer
);
    DROP TABLE public.loans;
       public         heap    postgres    false            �            1259    26077    loans_loan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.loans_loan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.loans_loan_id_seq;
       public          postgres    false    225                        0    0    loans_loan_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.loans_loan_id_seq OWNED BY public.loans.loan_id;
          public          postgres    false    226            �            1259    26078    paymenthistory    TABLE     �   CREATE TABLE public.paymenthistory (
    history_id integer NOT NULL,
    payment_id integer,
    loan_id integer,
    service character varying(50),
    paument_sum integer,
    payment_date date,
    user_id integer
);
 "   DROP TABLE public.paymenthistory;
       public         heap    postgres    false            �            1259    26081    paymenthistory_history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.paymenthistory_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.paymenthistory_history_id_seq;
       public          postgres    false    227            !           0    0    paymenthistory_history_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.paymenthistory_history_id_seq OWNED BY public.paymenthistory.history_id;
          public          postgres    false    228            �            1259    26082    payments    TABLE     z   CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    card_id integer,
    service character varying(50)
);
    DROP TABLE public.payments;
       public         heap    postgres    false            �            1259    26085    payments_payment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.payments_payment_id_seq;
       public          postgres    false    229            "           0    0    payments_payment_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;
          public          postgres    false    230            �            1259    26086    transactions    TABLE     �   CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    sender_id integer,
    recipient_id integer,
    sum integer,
    date_time_tr date,
    user_id integer,
    card_num character varying(50)
);
     DROP TABLE public.transactions;
       public         heap    postgres    false            �            1259    26089    transactions_transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.transactions_transaction_id_seq;
       public          postgres    false    231            #           0    0    transactions_transaction_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;
          public          postgres    false    232            �            1259    26090    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    iin character varying(50),
    password character varying(50),
    registration_date date
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    26093    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    233            $           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    234            G           2604    26094    account account_id    DEFAULT     x   ALTER TABLE ONLY public.account ALTER COLUMN account_id SET DEFAULT nextval('public.account_account_id_seq'::regclass);
 A   ALTER TABLE public.account ALTER COLUMN account_id DROP DEFAULT;
       public          postgres    false    216    215            H           2604    26095    branches branch_id    DEFAULT     x   ALTER TABLE ONLY public.branches ALTER COLUMN branch_id SET DEFAULT nextval('public.branches_branch_id_seq'::regclass);
 A   ALTER TABLE public.branches ALTER COLUMN branch_id DROP DEFAULT;
       public          postgres    false    218    217            I           2604    26096    creditcards card_id    DEFAULT     z   ALTER TABLE ONLY public.creditcards ALTER COLUMN card_id SET DEFAULT nextval('public.creditcards_card_id_seq'::regclass);
 B   ALTER TABLE public.creditcards ALTER COLUMN card_id DROP DEFAULT;
       public          postgres    false    220    219            J           2604    26098    insurancepolicies policy_id    DEFAULT     �   ALTER TABLE ONLY public.insurancepolicies ALTER COLUMN policy_id SET DEFAULT nextval('public.insurancepolicies_policy_id_seq'::regclass);
 J   ALTER TABLE public.insurancepolicies ALTER COLUMN policy_id DROP DEFAULT;
       public          postgres    false    222    221            K           2604    26099    loanapplications application_id    DEFAULT     �   ALTER TABLE ONLY public.loanapplications ALTER COLUMN application_id SET DEFAULT nextval('public.loanapplications_application_id_seq'::regclass);
 N   ALTER TABLE public.loanapplications ALTER COLUMN application_id DROP DEFAULT;
       public          postgres    false    224    223            L           2604    26100    loans loan_id    DEFAULT     n   ALTER TABLE ONLY public.loans ALTER COLUMN loan_id SET DEFAULT nextval('public.loans_loan_id_seq'::regclass);
 <   ALTER TABLE public.loans ALTER COLUMN loan_id DROP DEFAULT;
       public          postgres    false    226    225            M           2604    26101    paymenthistory history_id    DEFAULT     �   ALTER TABLE ONLY public.paymenthistory ALTER COLUMN history_id SET DEFAULT nextval('public.paymenthistory_history_id_seq'::regclass);
 H   ALTER TABLE public.paymenthistory ALTER COLUMN history_id DROP DEFAULT;
       public          postgres    false    228    227            N           2604    26102    payments payment_id    DEFAULT     z   ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);
 B   ALTER TABLE public.payments ALTER COLUMN payment_id DROP DEFAULT;
       public          postgres    false    230    229            O           2604    26103    transactions transaction_id    DEFAULT     �   ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);
 J   ALTER TABLE public.transactions ALTER COLUMN transaction_id DROP DEFAULT;
       public          postgres    false    232    231            P           2604    26104    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    234    233                      0    26050    account 
   TABLE DATA           X   COPY public.account (account_id, branch_id, user_id, balance, type_account) FROM stdin;
    public          postgres    false    215   �g                 0    26054    branches 
   TABLE DATA           O   COPY public.branches (branch_id, branch_name, branch_adress, city) FROM stdin;
    public          postgres    false    217   2k                 0    26058    creditcards 
   TABLE DATA           V   COPY public.creditcards (card_id, user_id, card_num, validity, remainder) FROM stdin;
    public          postgres    false    219   �o                 0    26066    insurancepolicies 
   TABLE DATA           g   COPY public.insurancepolicies (policy_id, user_id, policy_type, vehicle_num, started_date) FROM stdin;
    public          postgres    false    221   �w       	          0    26070    loanapplications 
   TABLE DATA           ]   COPY public.loanapplications (application_id, user_id, amount_requested, status) FROM stdin;
    public          postgres    false    223   "x                 0    26074    loans 
   TABLE DATA           ]   COPY public.loans (loan_id, application_id, interest, term, credit_sum, user_id) FROM stdin;
    public          postgres    false    225   �{                 0    26078    paymenthistory 
   TABLE DATA           v   COPY public.paymenthistory (history_id, payment_id, loan_id, service, paument_sum, payment_date, user_id) FROM stdin;
    public          postgres    false    227   �                 0    26082    payments 
   TABLE DATA           @   COPY public.payments (payment_id, card_id, service) FROM stdin;
    public          postgres    false    229   ��                 0    26086    transactions 
   TABLE DATA           u   COPY public.transactions (transaction_id, sender_id, recipient_id, sum, date_time_tr, user_id, card_num) FROM stdin;
    public          postgres    false    231   �                 0    26090    users 
   TABLE DATA           a   COPY public.users (user_id, first_name, last_name, iin, password, registration_date) FROM stdin;
    public          postgres    false    233   ��       %           0    0    account_account_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.account_account_id_seq', 100, true);
          public          postgres    false    216            &           0    0    branches_branch_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.branches_branch_id_seq', 100, true);
          public          postgres    false    218            '           0    0    creditcards_card_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.creditcards_card_id_seq', 128, true);
          public          postgres    false    220            (           0    0    insurancepolicies_policy_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.insurancepolicies_policy_id_seq', 111, true);
          public          postgres    false    222            )           0    0 #   loanapplications_application_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.loanapplications_application_id_seq', 122, true);
          public          postgres    false    224            *           0    0    loans_loan_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.loans_loan_id_seq', 119, true);
          public          postgres    false    226            +           0    0    paymenthistory_history_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.paymenthistory_history_id_seq', 115, true);
          public          postgres    false    228            ,           0    0    payments_payment_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.payments_payment_id_seq', 96, true);
          public          postgres    false    230            -           0    0    transactions_transaction_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 109, true);
          public          postgres    false    232            .           0    0    users_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.users_user_id_seq', 102, true);
          public          postgres    false    234            R           2606    26106    account account_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (account_id);
 >   ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
       public            postgres    false    215            T           2606    26108    branches branches_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (branch_id);
 @   ALTER TABLE ONLY public.branches DROP CONSTRAINT branches_pkey;
       public            postgres    false    217            V           2606    26110    creditcards creditcards_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.creditcards
    ADD CONSTRAINT creditcards_pkey PRIMARY KEY (card_id);
 F   ALTER TABLE ONLY public.creditcards DROP CONSTRAINT creditcards_pkey;
       public            postgres    false    219            X           2606    26114 (   insurancepolicies insurancepolicies_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.insurancepolicies
    ADD CONSTRAINT insurancepolicies_pkey PRIMARY KEY (policy_id);
 R   ALTER TABLE ONLY public.insurancepolicies DROP CONSTRAINT insurancepolicies_pkey;
       public            postgres    false    221            Z           2606    26116 &   loanapplications loanapplications_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.loanapplications
    ADD CONSTRAINT loanapplications_pkey PRIMARY KEY (application_id);
 P   ALTER TABLE ONLY public.loanapplications DROP CONSTRAINT loanapplications_pkey;
       public            postgres    false    223            \           2606    26118    loans loans_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_pkey PRIMARY KEY (loan_id);
 :   ALTER TABLE ONLY public.loans DROP CONSTRAINT loans_pkey;
       public            postgres    false    225            ^           2606    26120 "   paymenthistory paymenthistory_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT paymenthistory_pkey PRIMARY KEY (history_id);
 L   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT paymenthistory_pkey;
       public            postgres    false    227            `           2606    26122    payments payments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public            postgres    false    229            b           2606    26124    transactions transactions_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public            postgres    false    231            d           2606    26126    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    233            n           2606    26127    payments fk_card    FK CONSTRAINT     z   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_card FOREIGN KEY (card_id) REFERENCES public.creditcards(card_id);
 :   ALTER TABLE ONLY public.payments DROP CONSTRAINT fk_card;
       public          postgres    false    219    4694    229            e           2606    26132    account fk_employee    FK CONSTRAINT     ~   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fk_employee FOREIGN KEY (branch_id) REFERENCES public.branches(branch_id);
 =   ALTER TABLE ONLY public.account DROP CONSTRAINT fk_employee;
       public          postgres    false    217    215    4692            j           2606    26137    loans fk_loan    FK CONSTRAINT     �   ALTER TABLE ONLY public.loans
    ADD CONSTRAINT fk_loan FOREIGN KEY (application_id) REFERENCES public.loanapplications(application_id);
 7   ALTER TABLE ONLY public.loans DROP CONSTRAINT fk_loan;
       public          postgres    false    225    4698    223            i           2606    26142    loanapplications fk_loanapp    FK CONSTRAINT        ALTER TABLE ONLY public.loanapplications
    ADD CONSTRAINT fk_loanapp FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 E   ALTER TABLE ONLY public.loanapplications DROP CONSTRAINT fk_loanapp;
       public          postgres    false    4708    233    223            k           2606    26147    paymenthistory fk_payment    FK CONSTRAINT     �   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT fk_payment FOREIGN KEY (payment_id) REFERENCES public.payments(payment_id);
 C   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT fk_payment;
       public          postgres    false    227    4704    229            l           2606    26152     paymenthistory fk_paymenthistory    FK CONSTRAINT     �   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT fk_paymenthistory FOREIGN KEY (loan_id) REFERENCES public.loans(loan_id);
 J   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT fk_paymenthistory;
       public          postgres    false    4700    225    227            o           2606    26162    transactions fk_recipient    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_recipient FOREIGN KEY (recipient_id) REFERENCES public.account(account_id);
 C   ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_recipient;
       public          postgres    false    215    4690    231            p           2606    26167    transactions fk_sender    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_sender FOREIGN KEY (sender_id) REFERENCES public.account(account_id);
 @   ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_sender;
       public          postgres    false    215    231    4690            h           2606    26172    insurancepolicies fk_user    FK CONSTRAINT     }   ALTER TABLE ONLY public.insurancepolicies
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 C   ALTER TABLE ONLY public.insurancepolicies DROP CONSTRAINT fk_user;
       public          postgres    false    4708    221    233            g           2606    26177    creditcards fk_user    FK CONSTRAINT     w   ALTER TABLE ONLY public.creditcards
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 =   ALTER TABLE ONLY public.creditcards DROP CONSTRAINT fk_user;
       public          postgres    false    4708    233    219            f           2606    26182    account fk_user    FK CONSTRAINT     s   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 9   ALTER TABLE ONLY public.account DROP CONSTRAINT fk_user;
       public          postgres    false    233    215    4708            q           2606    26197    transactions fk_user    FK CONSTRAINT     x   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 >   ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_user;
       public          postgres    false    233    4708    231            m           2606    26187    paymenthistory fk_user_id    FK CONSTRAINT     }   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 C   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT fk_user_id;
       public          postgres    false    233    4708    227               y  x�e�M�[K���b���6�V���v���Nd�e�9v�O$O\u���>����؜������q<�9�M��z�ݾ���nGyn�� ����������cW���Ra����s�\���ε<����6����2Q9�:�y؎�2\g�������������eIX���s�|���ŗے�B�l&c/��D�Љ��/_����#w�vk� ��ж�PÍ������#Bcr���yQ�9�d{EaH4�/�����k�QF�>�� �}� ���kF!H�@N�HK��%|s��h$��]&����0�^�a�{����	)�7eL��$�V~�6&\�~JQ�4��K�1a��1�5~7x��k*���o�W\8c��Dkd����Ee��)+�jaA-NB������|9jW	�>y�G-P;�J�h�&��~t-�3��!Un�h�@���C?�8��Z��T��<hhѶ�G����:rZXY�(�ᛔZ�vtuͪ5��boT�r��MȊA(*�����o'�Y�E���t�[!������0D
���Y4u(q-wkDZ�zfl�t���V�W��.�O[H
٦�fE��E��\�c�f�B0\�mks��p-�@��wG�Fڅ����waxS���9�]���zQC�F��0%x��[ <hU�^,�����l��j�e�v�����␂-0޺���X��(L�|�F� HӽM4��Q��g-�Da�p�x}<�D��JXV�9�R(xm�(�xΥ�eO��tS�Y�s�6� �ҞO6�d�ND./&�2�b�G&�5��
�����RQ�T�V��f����7�e3O�Gz<7�_���~��x<�L��;         �  x�}Wے�6}n� )|��K��N�L%��}�+��2�>-.3�2<���ӧO�#���fyx+��x��C�(ѭ�]���4���A&%BU�+�NT��!3F`���ҋ�A'�3�2|3��k�P����m3�AG�~#0�j��{�`Kdp���;��p�j��� ��Js�_�k.�Fɠ�gJ��`?s*��ҿ�,H\p�#w��2�F��L�ڤ�b�"����_}8�@1�1�֊�-�*��V�����VzD	Lw��~�/w�����[.��I��X.Q`D<0!���F�6�(�;G����fr�ۅ
�nPKV�H'AD%<tҸ`\^*[&����HF��}֜q�0�#	+��sQ�q��mя�ޔ��@��>�*���-z³Gf�� �ᦫ�]��#�f��z�Ys&�FYA\������ܢ�
މ�N�����*HF6��f�\���H{5N/J��%$p�������ZKR�ѳ�����d�$Ԯ�R�$�l:�\y��ʧ�G�5�Z�.h,	�PdL��
5��v��U���9-�ƒ*܇�T1�`�d��E焊����J�O�	��=��uiJ6aؾ�K3j���_���P���#-�����NI���i��q%%)x�R=������M��G�-ٛ2=�9b�b��zrt��%�,������c�z�O�/����,����8�,������vj�p�������䄨����c��eYc;��zκڋr��|D�,��'�2�#��1��f��J��)���s�s�	|�����c�� I���V��kN�kz�|��<����9����oڏ�`,Ɋ�aRG��%ա)�����'�@}Q�}M��)b�v���z8�"�'.8��cE
OH���Ԯ �E%{M�zG�$\F�w?(
�>��e�.JZ!Ė]Xx�ʊ����_��n5_���Nc��������[�{Z]�Lhֱ5���ej��a��C�e�;����y�So�}+o�ea����5��,��ýW�4/���xaEʥ��޸s�hSj���W��'�MuQEv�&�{KJ��m���S�*�]`��g�y���TWV�������Nx&�Tҳ�yv9���h�����qq&��=���:�         �  x�M�ّ%)E�_�Zȉ������ ���^��Hwr����c�G�\&k]��~�?헯aMk]������e�n���I^�i���:���r���>�~�׍�k��y-�j�=�Ɋ5M��������F�[)]���2���ׅ^.c����u>?;et����O�O�+�%�f�s�U�h��w����Zf]��}��dɔ4�=��~���tJ�ݖ��m�ձy�e?YנY֤׺�GL��}��x�S���um"�`�n}�\�����>X��ѝo�y���=�N��M�.yj�|RTC��q���P_,ܘ�Q��f��ݟ�Q��n3���Mǌ6��������5 ��&w�L.	�}�([���)�ɆE������Nw��09*�lX��*�z��a��'W���p�bC;��#re�y��;p�ܛn`
ل5!}�C���7l�Ȧչ�����{4�5�t��ws�t��);6�~yGB(j��W��%�%w� 3.��Wo���S�
h
�5�6�Z�ܪ�Ɩ�@�j�A�)�	�+�ᎏ���z�Ԃ����pō�X�{����ĨZ���C�X���(��L�k�Цщ���������M���&�D�� JG!�¸,G�6��$r�6��}ǹS�ovlN���t���9ݺD��qɥ��B�P�{C�+*|�f�p��!��h��J���l�B��B��`��R�K�����j!���
��#0�����gG�Ɏ	�=�l���7.�+�Sb�{�@p��H����("���-;F頻6߸XϘ�E���~A�n���`10��գi�耀�70H��BD��ɂJĄ%��%S���cP~����724�Vb��Ľd0�9��͏`0(��c�H�˫�o`?%PL,r���6k���i?��u�����p���
��� �QDK�kK	7���t��$��DudIG/~�R�ꚇ\�O������|�q��t��a�6�``��Tr�&�C������m\ �l�X�����C�����o¼�c3�]�(�Q$���8��N{8�������`����Ye�t��$L�ώ�0�%\LA:�����ƹ(�DLIp�u����3!ą��i�L1� 3]�[�PqH�~�F1�F+��W cANx��L/�x5)0^{f'B��	��w ���YKu<�ځ O��w� X$��wjÿ�f��de؀��QŠ�츑Q
����2x+		Y�����mq����g��b##�pf��I��o֐ �W�8Cb�p��ʸ�'e
S�#�q�>0�̰�j�5���~dM�-@�+8;�'���͍�&"��Ԋ=��j����SO�&^�s����Qkb���^QY��@�~�cO�� �6�d0��1[�B�ǲ������t�>N�>_Y�V�\1���4�����/	�60)^8a�ܲ^�!XI\F�6���b�����ӿ�A�hB�g*#޹	�,**ob�p�A��#v��3�����rT���60�cV�F����ͬ��2��-��9�+e�G��w1��
B����k���V	s�z	����l�OvT�2��l���԰Ŝ����Af�����>��V?6�ۊ3���2�$��|���Ѩ��3.�ʫ��?�!�&/������ɢ�i��<F��h��3��5��0�Hf���)*72�O3�*b���=�i=H
��� Ë�7�7�I�}�S5���ȃ����(6��:���z/֐��9����5�q�I�c,G	���	����r#��USn=F�ٟG�֠�������%f�(�h�^cpn`�~" Z%JYרp��-�=�2V3C�!Io��/�e-��j0�����Ĭ�[�0�a8�2!��y�ٸ�̬�'�r!�������cf�5��q]���xe��R�_�o�I�E���ד���j�k����         �   x�}�1�0�9��߁�ޅŐD��*�F9��`!9Y���� =�]�����I+0��w�b�r.bI�D�ȺY4x�Y�E�G���oOͪE�eݳͭ���u�&��zT��hh>[�˲2�l�c�Bs��      	   �  x��Wۍ\7�ޭ"�l"��8��M�F�����C�u,eh0�1�H���%x��˓�O���߮�����O�����������gX��q��+��z}����\���!���<��!� c�������~���d�`ea	2nMx�p���T}y������q�?C�׈��.S�CX�m(OV���B�l�������43�"#3����(/^8��"�q�(oR$h���A��a\X< ���. �2&5��y7�of�9x,p��8��.7��z���-�)i8�(f��O�%Sm�g�i5d�	ڥbɕ��%��p�1E��3y����*\pH:°�v-8��(�D�f.OF
vZ�O\�ƔM�OQ��*l26P.�CVJ��r��q;�
����e��T.̝Q�4Y�$����z�i�pq��36E�t�1����|�^)E�Q�I�'�uʉP����.�}�}��9��x���٤uz��¢�V��iH��;���A��[-2�e�}"+v�_-2r��A+w�w�=Y�d@���m2AЩJ�L��5e�D:F�U�*|�]Y�%ceܔ�ڊ"F����#V��p[q�
�Ns�z��>{Lo���{�ٽ���b�RN����z�R[�#���m8:���br�7 ������ȱq��xs�?ا]�Η��xo1@����	��Ԑ��ԯ��n�P��l��u�@a�7�(��d~nEύ�2�eD/Qn��Ŋ�\�Q��65fS��/�s��(>39W�C�z��lb���ߪk�"Y�v���rHC�- |��הZIS�_x��x��<����t ʄl��<��J�.L����J��ӥݟ� �,�*�!���'��	q��;zy�˽c�9o!~�e4�� ������7��         (  x�mVۑ;��r�[�L�F���0��a��U�����iZ����{�B�־�`�v��k�l�ږ����>���R�9sr�i�^�}����)�p$<GM�`�p]�#��{0{b+����o`����\8�O�	�%��HΉAK��� �I���]���n�ra�fn	ҋ� �#6An�9���|�m��<�pW��(b6:UA��DZ���E�2)y��0
އ/ JZ=z&�����FP�+��&��A���P���q W�K�@n�44�j�M32S��8���h%Ҫ�&�hm�A����O<[`���{�.�Ń,�MZ�px\�Bؿ$��P�̽[ 'Av�H/��G��������b��K����k���dvwE#{��"��H�	���_��k��'yQm;� <����9�:	_�D�NTr�F�q��j\�[M����W�s`(�";C��Ns"}: �KО}F��ǤsS�����ri��~s+�n��)G��X����6�*K�2y�yj��Œx��!෷1�VrS�R&,ς��)+v7A}�aY�v�%lO�O��Ȓ&{#�ru�KH�{�2h���W���������X��	X�Z��Y���M�������.o�.�4>���)ݤ�dP����82��X��(�c���9Ͱ����9N]-r�5�����z�T�6_����ӄt�Z�:��P���n��w�Ԯ N��N��w�Φ�`9�고��xp�����j��Ho�x����l�>��_rݧA#X�����I�!!�j(�W��g���~��<��W��p����+w��F�Ɲ��V����@�,u�Y�Y�0LƜ���@KA�N֦w�·��w�M�O$��;|�~Ew�R���<W.�#qn$���sPӥ+GБs�D\��J�g�+ћ~�f�i=���u�2�|S�;����CH�t	�[I]�;�-0K,��芧���	_|��%2 ������烓A�T���%�;���s?��+
������0�;�_��/�r~Φ/��Y{�w8��Q�|Mp��y�Iݯ�]A��s�w�d]         �   x���M� ��p���s����6��������IeH�LX0��P4�X�1���@R��JJ�vl�n � ]U��R	Z�[m�q!�t.V�ջ����#���%!��̂�"�uͬ�����
��p�R,DƔ(:hυE��~%R<�<�����cv��ׄ2��$�� �Ix1         :  x�m�[v�0@�����Mt�1�!.0�LV_!&���OB>�ta/��_炟T{�&gG�{8�t�}�c��;�=����#;گ8��x����}�=����]��	�e�g{�m ���j[��8 ���ͧ���iM�_�����7����������	���؊@��'���F�����K}�8BE8��&~BE4��-SL8�Y�m�eq]�T�66a��@f?�܊E"�j������BU��v���xN(�Oo[�`���\^=��b�`�xlĉ���5lnjpⱫ��H8iq!D��T��3���	�	��qܜ�n~�3�Z��|<r��-��A��"���A1%?$ܪ��ބ*�!j���>"���`�ةI,�lɎ�w���p���Q�¹���<�'Un�|�h]ݴOB��JY�V�Ki�b�y�*��x�x%2W��,R*E�Se�Eՙ(�R��Y&����h�C-NQ��DѪE�\mJQ�S�Cs�E1��T?E1<Ŕ?���(Fe���b�SS��ԗS������S���G�Z���2�V�(�� �/�ތ6         �   x����1г�p�`��#8��F��i�'B�s����
�P9!�T6�tM`�5w�1�Ohhx�D�*�\DN�$��3z�=��T��-2p�(b�������=��&��LS�Sx���1�|��U�         �  x�UXiS"M���/<�cuu���oo�`����a Y���f���o���U���%%�Q���4��Q�kδ��pN9#��]is��%�g����0�1���ޘT�^��t�!�o4�ڐ�C�~:{C���j�E�?���I!�בo;m��f�6J3+-�[1[���p�;���|O�b;��Y���j���\�"JHJ������ ݙ��r�I�;�#Cr�j�)1�P�s�%Hz,�ַv㧭�Ɍ+L��v���"
Qa8&�E��QM:gr�z��a4��%\�&�$M��<�fD��3&���'�#�z�Y�n�����!;Ao��4��A��q��)�T�T�)��r2�:�O=K��N�l(+�Ǆ
_[k��T��	��</�*��.�£>9v�Ј"�Ռ�`JLcb���������a�im;o��(%�0�z��T��1"F(i)�LiI��z�sw�V;�|G�?�y��� ����E�A_3���@�O��ۙ;���:��w��I=hFA��В,#Ȥ�O��F��ζ��󭕷IC���CG8��~;R´�6>7$=��ϵ���ۤ�Y�=	��$;I���a��|f�2�rK�2���8���w3��aUzhua������	��|X��B�\��T�mA'5:�#�Y���+�d�
A	�_��J߼��썦�x�w���!{���6^��4��)���>��][�ԯV�V(�/%���0�QKJ�cL��{�UV"�����[�=�<�;Oϭ��wuc�K���)C"�V�5�Ս.�G����W� J�����hG!�(�,���T$(��J=��{�Y�M�C�C�{9
�^3D��Z��dT�+�������o&�ȇ��0E3�v�z@��OC�xϮ�r�K�������f���c������i�o��O�2N%�yc�6�{M�1��߰�J����4g�F����<\���?�G�H�� v�J��c�Uh��b���e�>4�
��)@�`��grdY���v@�T��L�b�ͬ�iq���=�%���#�p�ڒb"�d>W�Z�4+�W��4�����,�	����Oa3 �dK-(�ZOW���mp�z6�0t�)�!���QL��|*)��������-��	� NI9�IH�B0X
�Iɰኁ)�.�VZ�۫�k����D.FvӰCJQ���c�����A����ԟ���l���x�/=���N�0�h�@�@�!ə��?��7������������A�ɨO,������V�./6�6Z�G�\Xiρ�5:n�c	@|�CE���}�����2)o�DF�Ԃ���5>pteV���gi���_���Q�H���DSc,
�Y|�l0�Y:Jn^s1@:CJI8-�H�H&�TƂ�y����b<w:`&�M��4iB�p��O�������ԃ���-I�Q��c�5])k},��T��.���H*+�/?�JPR	z�0Y&�R �	 ���;fzs`����mL�B ֦�����RX�cE5���n岡=�I5�D`դ�H��~YI�8in��ի����\�&(�x��j��,��W��cF��c
I�֓�*���6��  ($9��FA�t��hi O��ʭet55�~���/�s��
�؋b׎V,I��aυ��툍���R��ȧA�iG��[�!� #�(�+������������O��N\�"��4���a��%᱿�^T�õ_�y�܃2�4pG9��������Ab �f)QU��{�&����?kB��4�����B!A"A�_������5[��8e���8��z-X/.�˕(���+����Y۸|�_��MzL�����m�A�W��U�[�龹r85�h�	�1�~����)�e��S�R�}<� ��r�C�p]�Ghg�l$�a���
�ܙw��8ܬ��L�{Rb� �-#�g1�UK(th%�+�z1۟{XX�=�.��}T�������]T+�tx��cŢC�r�ߎ{���'x����D���^�FRn"�'l*\�.��v緲	�a�!�0��/��/�k9��H�]��+�+{i9�2�&<�N����|_�bu��%��T���V/��c3V�rŲ���5�8�q�Ӡt᫬�+�!x�SU�W��ݔI�
���J^8�m��>�������:����~�6W��0"'��% F��6��aY�,�4^fZ���|������ �^ӥ"�5H�ᮂ�i����#�S�A�{�΍��c�QVg֙g��$�ы����?eQIrt�cxm�wdD5���Np�������������l��S ��^��@�[#���b�TY��5^lE����l�&�*M�i 3TH����@���.�1���͆ػZ��4�]V�� k;�\�`�a�0���s����Y�:��I�d/I��>�^�8�T$<�K7����{ ���uϦN!%$�аj�4o���Ai+� "���ܤ�A�c�-�V�M�#�g�V�O�T&\�BؿO�u"�ŧk�]��ywkd�+Os�},F�F�M�5���w���6���:;��X.��c<z%��ܝ�]>�kJ[8Mh�ҷ��;����a+o�)A�u�v�:gb��}��w���*�o$�-�A�
Ƴۍ�Tu��r���4Il�un��|s[/^�LRQZ��4lF��.AiJq�I������~g�go���q��ِ�n7���L��6��X��@��)�yR��گ�1�8���`Z���I<F7ta��Gj7�6�ZMO������u���3Н0n���0� ��A�,i�����S5	�@��A�A�Q=la���{�7,�ӥyX�:�͍�@���й��?JR ��團�i�x�V?i���ʼ!H�n�4������`��_����)n��1�������CE����-UH�/� �d-���q%юXi�v���c�����yF��8�7��.� ��AS�8����K3s.�·����FRؓF^.���8��C�iT�͇��+}o.����|�W�Q�H�q�
��%��]�#1������
A�U"�
��0�����ə���U����S#��ס�]5�A'�Nac8n6�%�]1S_X���1^��$'i�&`^���҄{�4F��N�6;�����0h&�++�}�}�j�(���.%�� ���k�j��0?pa%H_�Ƞ���Z�&}̛��	]���G2��,��+����>�X`�k�|�_T\�z��f@֭pz�ƚ8��Ew�x�_A?���D�j�����y�u=4�t	��u��A 
�Ղ�#�;�G��l0��ֳ
t���z�'\�A8�D^.e�֓b�k�m�j�<c ��	��i��,�p�3!��dx!�[j�w&fcZ�RϚ/�qy�L�W?T���a��}��|�vau2
г��*��tLvƙC26��|���5}�؟^�&������.�O�
z�0º:$_�z�sk�;������q� ��V�(l���8��	��][�<�L8l�     