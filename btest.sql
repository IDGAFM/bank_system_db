PGDMP                          |            bank_system_db    15.4    15.4 B    i           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            j           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            k           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            l           1262    49194    bank_system_db    DATABASE     �   CREATE DATABASE bank_system_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Kazakhstan.1251';
    DROP DATABASE bank_system_db;
                postgres    false            m           0    0    SCHEMA public    ACL     *   GRANT USAGE ON SCHEMA public TO postgres;
                   pg_database_owner    false    5            �            1259    49195    account    TABLE     �   CREATE TABLE public.account (
    account_id integer NOT NULL,
    employee_id integer,
    user_id integer,
    balance integer,
    type_account character varying(13)
);
    DROP TABLE public.account;
       public         heap    postgres    false            �            1259    49198    bankemployees    TABLE     �   CREATE TABLE public.bankemployees (
    employee_id integer NOT NULL,
    branch_id integer,
    fname character varying(50),
    lname character varying(50),
    job_title character varying(17)
);
 !   DROP TABLE public.bankemployees;
       public         heap    postgres    false            �            1259    49201    branches    TABLE     �   CREATE TABLE public.branches (
    branch_id integer NOT NULL,
    branch_name character varying(50),
    branch_adress character varying(15),
    city character varying(13)
);
    DROP TABLE public.branches;
       public         heap    postgres    false            �            1259    49204    creditcards    TABLE     �   CREATE TABLE public.creditcards (
    card_id integer NOT NULL,
    user_id integer,
    card_num character varying(50),
    validity date,
    remainder integer
);
    DROP TABLE public.creditcards;
       public         heap    postgres    false            �            1259    49207 
   currencies    TABLE     �   CREATE TABLE public.currencies (
    currencies_id integer NOT NULL,
    currencies_code character varying(3),
    currencies_name character varying(6)
);
    DROP TABLE public.currencies;
       public         heap    postgres    false            �            1259    49210    exchangerates    TABLE     �   CREATE TABLE public.exchangerates (
    rates_id integer NOT NULL,
    base_rate_id integer,
    quoted_rate integer,
    exchange_rate integer
);
 !   DROP TABLE public.exchangerates;
       public         heap    postgres    false            �            1259    49213    insuranceclaims    TABLE     �   CREATE TABLE public.insuranceclaims (
    claim_id integer NOT NULL,
    policy_id integer,
    payment_amount integer,
    date_payment date
);
 #   DROP TABLE public.insuranceclaims;
       public         heap    postgres    false            �            1259    49216    insurancepolicies    TABLE     �   CREATE TABLE public.insurancepolicies (
    policy_id integer NOT NULL,
    user_id integer,
    policy_type character varying(21),
    policy_sum numeric(8,3)
);
 %   DROP TABLE public.insurancepolicies;
       public         heap    postgres    false            �            1259    49219    loanapplications    TABLE     �   CREATE TABLE public.loanapplications (
    application_id integer NOT NULL,
    user_id integer,
    amount_requested integer,
    status character varying(19)
);
 $   DROP TABLE public.loanapplications;
       public         heap    postgres    false            �            1259    49222    loans    TABLE     �   CREATE TABLE public.loans (
    loan_id integer NOT NULL,
    application_id integer,
    interest integer,
    term date,
    credit_sum numeric(8,3)
);
    DROP TABLE public.loans;
       public         heap    postgres    false            �            1259    49225    notifications    TABLE     �   CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    user_id integer,
    notif_text character varying(30),
    notification_date date
);
 !   DROP TABLE public.notifications;
       public         heap    postgres    false            �            1259    49229    paymenthistory    TABLE     �   CREATE TABLE public.paymenthistory (
    history_id integer NOT NULL,
    payment_id integer,
    loan_id integer,
    paument_sum numeric(8,3),
    payment_date date
);
 "   DROP TABLE public.paymenthistory;
       public         heap    postgres    false            �            1259    49232    payments    TABLE     �   CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    card_id integer,
    payment_sum numeric(9,3),
    payment_date date
);
    DROP TABLE public.payments;
       public         heap    postgres    false            �            1259    49235    transactions    TABLE     �   CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    sender_id integer,
    recipient_id integer,
    course_rate_id integer,
    sum integer,
    date_time_tr date
);
     DROP TABLE public.transactions;
       public         heap    postgres    false            �            1259    49238    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    iin character varying(50),
    password character varying(50),
    registration_date date
);
    DROP TABLE public.users;
       public         heap    postgres    false            X          0    49195    account 
   TABLE DATA           Z   COPY public.account (account_id, employee_id, user_id, balance, type_account) FROM stdin;
    public          postgres    false    214   �P       Y          0    49198    bankemployees 
   TABLE DATA           X   COPY public.bankemployees (employee_id, branch_id, fname, lname, job_title) FROM stdin;
    public          postgres    false    215   �T       Z          0    49201    branches 
   TABLE DATA           O   COPY public.branches (branch_id, branch_name, branch_adress, city) FROM stdin;
    public          postgres    false    216   YZ       [          0    49204    creditcards 
   TABLE DATA           V   COPY public.creditcards (card_id, user_id, card_num, validity, remainder) FROM stdin;
    public          postgres    false    217   �^       \          0    49207 
   currencies 
   TABLE DATA           U   COPY public.currencies (currencies_id, currencies_code, currencies_name) FROM stdin;
    public          postgres    false    218   �f       ]          0    49210    exchangerates 
   TABLE DATA           [   COPY public.exchangerates (rates_id, base_rate_id, quoted_rate, exchange_rate) FROM stdin;
    public          postgres    false    219   +h       ^          0    49213    insuranceclaims 
   TABLE DATA           \   COPY public.insuranceclaims (claim_id, policy_id, payment_amount, date_payment) FROM stdin;
    public          postgres    false    220   �i       _          0    49216    insurancepolicies 
   TABLE DATA           X   COPY public.insurancepolicies (policy_id, user_id, policy_type, policy_sum) FROM stdin;
    public          postgres    false    221   Km       `          0    49219    loanapplications 
   TABLE DATA           ]   COPY public.loanapplications (application_id, user_id, amount_requested, status) FROM stdin;
    public          postgres    false    222   �q       a          0    49222    loans 
   TABLE DATA           T   COPY public.loans (loan_id, application_id, interest, term, credit_sum) FROM stdin;
    public          postgres    false    223   u       b          0    49225    notifications 
   TABLE DATA           `   COPY public.notifications (notification_id, user_id, notif_text, notification_date) FROM stdin;
    public          postgres    false    224   jz       c          0    49229    paymenthistory 
   TABLE DATA           d   COPY public.paymenthistory (history_id, payment_id, loan_id, paument_sum, payment_date) FROM stdin;
    public          postgres    false    225   �~       d          0    49232    payments 
   TABLE DATA           R   COPY public.payments (payment_id, card_id, payment_sum, payment_date) FROM stdin;
    public          postgres    false    226   �       e          0    49235    transactions 
   TABLE DATA           r   COPY public.transactions (transaction_id, sender_id, recipient_id, course_rate_id, sum, date_time_tr) FROM stdin;
    public          postgres    false    227   ؇       f          0    49238    users 
   TABLE DATA           a   COPY public.users (user_id, first_name, last_name, iin, password, registration_date) FROM stdin;
    public          postgres    false    228   ��       �           2606    49305    account account_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (account_id);
 >   ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
       public            postgres    false    214            �           2606    49338     bankemployees bankemployees_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.bankemployees
    ADD CONSTRAINT bankemployees_pkey PRIMARY KEY (employee_id);
 J   ALTER TABLE ONLY public.bankemployees DROP CONSTRAINT bankemployees_pkey;
       public            postgres    false    215            �           2606    49345    branches branches_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (branch_id);
 @   ALTER TABLE ONLY public.branches DROP CONSTRAINT branches_pkey;
       public            postgres    false    216            �           2606    49286    creditcards creditcards_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.creditcards
    ADD CONSTRAINT creditcards_pkey PRIMARY KEY (card_id);
 F   ALTER TABLE ONLY public.creditcards DROP CONSTRAINT creditcards_pkey;
       public            postgres    false    217            �           2606    49331    currencies currencies_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (currencies_id);
 D   ALTER TABLE ONLY public.currencies DROP CONSTRAINT currencies_pkey;
       public            postgres    false    218            �           2606    49324     exchangerates exchangerates_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.exchangerates
    ADD CONSTRAINT exchangerates_pkey PRIMARY KEY (rates_id);
 J   ALTER TABLE ONLY public.exchangerates DROP CONSTRAINT exchangerates_pkey;
       public            postgres    false    219            �           2606    49258 $   insuranceclaims insuranceclaims_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.insuranceclaims
    ADD CONSTRAINT insuranceclaims_pkey PRIMARY KEY (claim_id);
 N   ALTER TABLE ONLY public.insuranceclaims DROP CONSTRAINT insuranceclaims_pkey;
       public            postgres    false    220            �           2606    49244 (   insurancepolicies insurancepolicies_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.insurancepolicies
    ADD CONSTRAINT insurancepolicies_pkey PRIMARY KEY (policy_id);
 R   ALTER TABLE ONLY public.insurancepolicies DROP CONSTRAINT insurancepolicies_pkey;
       public            postgres    false    221            �           2606    49265 &   loanapplications loanapplications_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.loanapplications
    ADD CONSTRAINT loanapplications_pkey PRIMARY KEY (application_id);
 P   ALTER TABLE ONLY public.loanapplications DROP CONSTRAINT loanapplications_pkey;
       public            postgres    false    222            �           2606    49272    loans loans_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_pkey PRIMARY KEY (loan_id);
 :   ALTER TABLE ONLY public.loans DROP CONSTRAINT loans_pkey;
       public            postgres    false    223            �           2606    49251     notifications notifications_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public            postgres    false    224            �           2606    49279 "   paymenthistory paymenthistory_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT paymenthistory_pkey PRIMARY KEY (history_id);
 L   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT paymenthistory_pkey;
       public            postgres    false    225            �           2606    49293    payments payments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public            postgres    false    226            �           2606    49312    transactions transactions_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public            postgres    false    227            �           2606    49242    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    228            �           2606    49273    loans fk_application_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.loans
    ADD CONSTRAINT fk_application_id FOREIGN KEY (application_id) REFERENCES public.loanapplications(application_id);
 A   ALTER TABLE ONLY public.loans DROP CONSTRAINT fk_application_id;
       public          postgres    false    223    222    3245            �           2606    49332    exchangerates fk_base_rate_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.exchangerates
    ADD CONSTRAINT fk_base_rate_id FOREIGN KEY (base_rate_id) REFERENCES public.currencies(currencies_id);
 G   ALTER TABLE ONLY public.exchangerates DROP CONSTRAINT fk_base_rate_id;
       public          postgres    false    218    3237    219            �           2606    49346    bankemployees fk_branch_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.bankemployees
    ADD CONSTRAINT fk_branch_id FOREIGN KEY (branch_id) REFERENCES public.branches(branch_id);
 D   ALTER TABLE ONLY public.bankemployees DROP CONSTRAINT fk_branch_id;
       public          postgres    false    215    216    3233            �           2606    49294    payments fk_card_id    FK CONSTRAINT     }   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_card_id FOREIGN KEY (card_id) REFERENCES public.creditcards(card_id);
 =   ALTER TABLE ONLY public.payments DROP CONSTRAINT fk_card_id;
       public          postgres    false    226    3235    217            �           2606    49325    transactions fk_course_rate_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_course_rate_id FOREIGN KEY (course_rate_id) REFERENCES public.exchangerates(rates_id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_course_rate_id;
       public          postgres    false    227    219    3239            �           2606    49339    account fk_employee_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES public.bankemployees(employee_id);
 @   ALTER TABLE ONLY public.account DROP CONSTRAINT fk_employee_id;
       public          postgres    false    3231    214    215            �           2606    49280    paymenthistory fk_loan_id    FK CONSTRAINT     }   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT fk_loan_id FOREIGN KEY (loan_id) REFERENCES public.loans(loan_id);
 C   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT fk_loan_id;
       public          postgres    false    223    225    3247            �           2606    49299    paymenthistory fk_payment_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.paymenthistory
    ADD CONSTRAINT fk_payment_id FOREIGN KEY (payment_id) REFERENCES public.payments(payment_id);
 F   ALTER TABLE ONLY public.paymenthistory DROP CONSTRAINT fk_payment_id;
       public          postgres    false    225    3253    226            �           2606    49259    insuranceclaims fk_policy_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.insuranceclaims
    ADD CONSTRAINT fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.insurancepolicies(policy_id);
 F   ALTER TABLE ONLY public.insuranceclaims DROP CONSTRAINT fk_policy_id;
       public          postgres    false    220    221    3243            �           2606    49318    transactions fk_recipient_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_recipient_id FOREIGN KEY (recipient_id) REFERENCES public.account(account_id);
 F   ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_recipient_id;
       public          postgres    false    214    3229    227            �           2606    49313    transactions fk_sender_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_sender_id FOREIGN KEY (sender_id) REFERENCES public.account(account_id);
 C   ALTER TABLE ONLY public.transactions DROP CONSTRAINT fk_sender_id;
       public          postgres    false    227    214    3229            �           2606    49245    insurancepolicies fk_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.insurancepolicies
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.insurancepolicies DROP CONSTRAINT fk_user_id;
       public          postgres    false    3257    221    228            �           2606    49252    notifications fk_user_id    FK CONSTRAINT     |   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 B   ALTER TABLE ONLY public.notifications DROP CONSTRAINT fk_user_id;
       public          postgres    false    3257    228    224            �           2606    49266    loanapplications fk_user_id    FK CONSTRAINT        ALTER TABLE ONLY public.loanapplications
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 E   ALTER TABLE ONLY public.loanapplications DROP CONSTRAINT fk_user_id;
       public          postgres    false    222    228    3257            �           2606    49287    creditcards fk_user_id    FK CONSTRAINT     z   ALTER TABLE ONLY public.creditcards
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 @   ALTER TABLE ONLY public.creditcards DROP CONSTRAINT fk_user_id;
       public          postgres    false    217    3257    228            �           2606    49306    account fk_user_id    FK CONSTRAINT     v   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 <   ALTER TABLE ONLY public.account DROP CONSTRAINT fk_user_id;
       public          postgres    false    214    3257    228            X   �  x�e��n9���Y�")��7i��l�8(�����9���f$~���X*"6�^���v�tZG�i���������~�-��D�A����/����SZְT���v}�AFˊl���-˝ٺ�?:-K���Я�?�̠���F����_o/�_~\����ʼ=͍
�a��d �,$�����'x��j�u�����/�+C����l�bͻn�*�{wc�������
���h�ŗ��B��&�+����F�ݰި`M�5�%��AXk�	�H�ĸKd��B�'�cx��8Vd�@6�W��`v	?�2�0��h7۩���狂�P+��d{R1����&�Q��y~M �IW��n�Z������D���\!J����=�`�ioPa����qϩ�����PG�"��&f9HW�����������z� v�@��ZD'(�v����F��C|*����L�G(t��`T�*ìU4�B��y�Bc����*LT��<hR���v��;L���E)�n���X!:E�h��RjB�cG�(VsDq�@C���?7!� &��(�G0�	�t�88?Ɉt�x�-��hC۩w��"R8]�@���vm����OiI��1��-a�����I��Mw瑺��f�rC���Pd>f�+L���F�*���l[��&�����C����*�[���������tVI�
I,��0�@p��T�F���7j�|��?��Q	A�{;�5z��$s�QǬ�H*�]�L ^_�ζ�T�`�=�����ǡ��0�ɇl��Fy�4-mbl`LL8�������������1Ã�R,_",���Li�ǳP�ϱ�5D����˩�!���9�ގ�gE�bm����G����["�r2����T�B4�����"h�8um�t�	��>9�z�0�?�ύ�|?=�L]e���.���#�wu      Y   �  x�m��R�H��O�lٖdI��߀��6K*��i�A�X�aG�<��!�������t�>=�b��jkZ,d�� f{lu���3\I!��Դ�&�p�epf�B��S�n�B�XYWp��&��Z٪����l��K�e�Ⱥ�9���5�֪(*qx�&�R��j״G1b,�W��\2۶��$��u�����SYپ�*E���\a�M�e��p:Yj޳�,���rN�9�t
rRs3�U�T�Z�M��lZy|�.ǥT��慄 k�p��q/���
A�m+�éԊq�J�)eǍp��U�;O� ~�w9/���� _����lU^���		ȧ��I5z�d�#˵K��RI��d6�q�i5���PPMA6�J^�/�b�g8�u�+��ҟ���R۔ֵ�\c���X1���^w��K�ib�\�m����l�'�grď�� k��jl,�W�)�Rf+L�8��=���Y��Wk�A��	��:]aa��Ct�)�I.8�g����@nv�!,��u�������&�)����!��7�~����Ƀd�����r�g0�T���kP�rm38t���q�p!�o�_��lt�R��Ve=X�"���Ѡ��d2����ƥ�U?�d����R���@�h<��jh.���0 ���[�l���ɐ�Zv�Wyz��0�+��m��\�K��^��K��9ve_���A�&Q���ؤd%�>>�ʖ�9�,Y�'�b�W4��-�]U/���~>���(����@����^X˸�g�7v�(@䫘����R�jX�Q�Y���]��3��D�V�o��b�+s��;e�\آ���� Km��dg�	���2����n�p�(�jh��(�O@�Ջ�(T�Uh��w>9c u�w���]t>Y�w��Jq�� �V�r�����!����D��:Ռ�f�,�or<�勴l�͡[�]�K�,񮟞�����o�������T����l%]/�y
rJf@x�5V\�d�M�?N$�|�oOA�vοW����@|�}x��[�^r�I3Q�Щ[�R���L��M�DZu��89c۪p��X�#�g[�ovE)���s�뎝��zt�/�����}�G�WmZj+o�qr+���f�TK9�H
r����SG�=$0���ٯ�/m�#O���������%�jT_i��'��m�N�ʲ<k��S�w�Kq�P0Ir��)�8�y�@�^�/(�j6V_��p�9ȉ����&�#;I�kL�{׎�0�s1�w>x.)��_O���)�Z��;�'�ws��t��;%=���?��O�NAx��^rg;����@�:�Z�ь7@����۰t(�C>���6�;3��@aW0�׊��_��qN� ����κm_i��o8Hݎ�j����J�o����.��;嫋F�pς���Ӊ}O�K�1���]��i?��_GGG���/      Z   �  x�}Wے�6}n� )|��K��N�L%��}�+��2�>-.3�2<���ӧO�#���fyx+��x��C�(ѭ�]���4���A&%BU�+�NT��!3F`���ҋ�A'�3�2|3��k�P����m3�AG�~#0�j��{�`Kdp���;��p�j��� ��Js�_�k.�Fɠ�gJ��`?s*��ҿ�,H\p�#w��2�F��L�ڤ�b�"����_}8�@1�1�֊�-�*��V�����VzD	Lw��~�/w�����[.��I��X.Q`D<0!���F�6�(�;G����fr�ۅ
�nPKV�H'AD%<tҸ`\^*[&����HF��}֜q�0�#	+��sQ�q��mя�ޔ��@��>�*���-z³Gf�� �ᦫ�]��#�f��z�Ys&�FYA\������ܢ�
މ�N�����*HF6��f�\���H{5N/J��%$p�������ZKR�ѳ�����d�$Ԯ�R�$�l:�\y��ʧ�G�5�Z�.h,	�PdL��
5��v��U���9-�ƒ*܇�T1�`�d��E焊����J�O�	��=��uiJ6aؾ�K3j���_���P���#-�����NI���i��q%%)x�R=������M��G�-ٛ2=�9b�b��zrt��%�,������c�z�O�/����,����8�,������vj�p�������䄨����c��eYc;��zκڋr��|D�,��'�2�#��1��f��J��)���s�s�	|�����c�� I���V��kN�kz�|��<����9����oڏ�`,Ɋ�aRG��%ա)�����'�@}Q�}M��)b�v���z8�"�'.8��cE
OH���Ԯ �E%{M�zG�$\F�w?(
�>��e�.JZ!Ė]Xx�ʊ����_��n5_���Nc��������[�{Z]�Lhֱ5���ej��a��C�e�;����y�So�}+o�ea����5��,��ýW�4/���xaEʥ��޸s�hSj���W��'�MuQEv�&�{KJ��m���S�*�]`��g�y���TWV�������Nx&�Tҳ�yv9���h�����qq&��=���:�      [   �  x�M�Y�0������K�]��9��&�h�x��-2dlѽ�cy�s�.���G��"l��Qn�f��Zz���g����*�3mؐ8kg��+���gcl=;�����/N�4��ϊ��^2���,1~����5->K8�p�Gmƈ���sq��=v�4����s�u�g���g-?[�(���l�N�3�a[��2_+�)�qߦ)�jKq���{�wSV�36U�)k0O����f��[NeG[:E�R�f��Syκ�'�l�����G,>�y�ּK�}v��)4��©k񤨆ƽ�a��P?L�B>ʸ�Qb��˟��w9˲b�7��mo�͡�[w��!���;�Ξ�v��5��ȽJrJ��7���2J#!٪&g����w�b=�S��Y�k0l�z`uG�Z7fNW�����l�Y���닚}adX��I�zh^���<���5�l5�2h��S��b���� �_p&qpk�|uJ٤;r_��Pe���#ߧ������q�DZ˩&�`�Q �E�uw�>�3�}D�ڭ񽫎w������ �G��4�Mm�$v�% ��焠���>������Щ� 7�:�Z�WT?"Mj�2'�`=�(�0��j��4�>h����9D�3�Ř�DY�ɜ�J/+�7��2����B�P�{A�\@���|0\8��;�pN� �@�|M�̠��@Qh Xr+�Wh�q)�)=���~���h垜���A%X�LԖDC�6g�hP2��;���k }A�7�6�R��QH@�YV���r�h�wk*�= �h�}U��Y�����tXl���/�)� ���U�.�G�6>6ж�dVD���t��(��BkS�I��g"���=�Π��ӑ1��@�z� :�~�q��&��F�)~ c���w����vԔ�q!���^�`���6�����[���06�_�6�^���,�����~no��/|�f��Z_HpD;�`��m���`Lr�_ǭO��\m���)�Qk��KR�z@�f	XϮ�;�/4�e�8�֣��iv��s�`�M�7Xrd #���4�D�����'�ac��b{Y~��5w��lb���4�N�0�|V�.���b	�)�W�� i���@���c=����o>�����ž#��+�L�z'2X2��r�1�FۊrǏt����H�j�x)^{R�E��~
N����gO��P�2p��Ϡ-m1A1,����/����1�0�qy����ɟF_V�fEpDk�� �RO��c�V
2��
-8������O'�?P�	 	�������`��b�'4lSpA�Z��K%��4�i4�RJ�=��^Q���dm>�d֡�h{��q��@�&�cp݂iV�񼷦�,V�J��5��{�?��3^�L�(�x[e/���ǚ͒��3	ȝ���(��(�V�}B�� g��uL��?Zw��krD�T�vLm\m���4p$_b�3	�4�ĻOF�[�Oy0V�H7I�=����^8�})h-�0I���9C��c�`� 6����m�-�|x�<�mx{���1ks����z3+�嚴u�(N��]}4�G���m��g�6s:�y@���ܮ��jE!v����0�G�\Iyh+�>�.��$��ӧ}oe�p���%��B�z(���p��O��^t4:b͓�t2ӎF�!�?�"!��/��W����;�Es���<���L��r�#�!̄��2���HQ�h����]���t�c��KNA5&y��'�iJ���*Jߵ�:��3#�����6�(D����0�_;$,|�\����;#d�B:" ��(�O��0�g��f	���}!Rn���ٟݴ��,��sw;�-B/�뱣譡{��"9Ú�ݘ�U���uG �d��'�tK�&C����$��z�Z6��.��C���_ٞwx��WLB@L� ��V�}���O���9��n�      \   `  x�U�1k1��S,K���4S�4YJ�B��@ ����ϛ}OOzz�O����r|�\/k����~[u9������{Ymy�<�!��]����;��tn[���=>z�/��z�
KE�_�cE)�%�S<��i;ԠY�q9QR���r���M�2�s�`CnT��&�V�]�Ut�A7������A�4	�$LFQ�,c:��q#8s�+JZ�3��iE�i��L�Ma�P�+Z�LC(�	��r����:�uCN	��˨S!n�z��u3b�2�Wnc5ʫeJ�،Zy�6��o��@k�h�'nP�
���JSZ� [��H�B�#2���eڈ(Px1��$�YR�[_/���Z7      ]   p  x�M�ɭ�HE����4D�8�����2l=ЂZݣ�hg8��8��A���c��X�;6��ü��h�zoS�S�S���%����5����-&�?�n�����%��%��K��K��K��K��K��K!A!A8����%�CHIHEHMHCHKHpn^�s���������o^�s�����ܼ�O����K�)A)A:)A)A����(A)A6)A)A.)A=�e���u(	*���C A5%A%A-%A?�m����}h	:i	���ރ(A-A/-�<�c���s	&	�	��o�e �,#�>�k���{X	6Y	�X	�Y	v�o݅��F���d�����������      ^   �  x�U�Q�)D��.�!�w���c���Z��c�H�	��J.�.�͟>@31qu�sh�\\b��}h��ӭbi�H��6�?�s��|>jmɒ]9w��i+O�eKI��ׯ�zt����yrR�6������9V���_��8�&`F����ˆ��:X�ډ��t
�����Ǫ��F�'�4�𺴉Nٗ�t�;�Ǣi	Q�ӵS��K�A*+z�S܍j!���ܨٌj]�r�%m7hl�^$՛M��qr秒E����z��v����	J��vۭ\IP�Nu?�@ǡ�ex�/�F����0���ӤV��n��x�Ψ8��I���=.K�)`�\�&��K��5�7�c�
���W3�N,ɬ��<z0O�b�=�b��{P�Lϕ$FWqOd��X�P�~|��f���1��6&�%�ƸW�%i��O]���J�6�h9�U	Ǹ�C����]6t�˱ڦr&k��f�ؕ�tZ{g{4��n�E�c�X @k�:uӓ�L�*x)?�\Rk^P׀�C�V٪�07��u�?�sl,+�6�� �X-^u�;�:@�V��ږ�5��}/�5�6����¬��1��lF��f���$!���$~���nd@�Q�E�Y c帝B�P�1׸�pj���5�N�|͟Gl�ܸ������- ��r����v+(���; ������Z���@K�׊QȰvp�V�-����3�������k��x�+�j��8�l��ֱ��C�/Ϻt�r$���o���d\R���r���o䵚~��v3��
L��h����M�V���\���$OX��-�j����ځ��VS�6�Y(�+c�1�c���x>.|�,(B������d��Y=_=���!$�uݽ?� =��K&�����/�߫��?��� ⋃P      _   ,  x�uW=n^9��S���O�e�1�)� ���;�U"ECO5�cbz���ǧ����������T�k��!$��oo���x������{�,����������O�/��/\s�#�|�V�]��oW�����#(.�sq�4ˑ�{���0�QT�ػc�h����Z:s��E�?�Ko��X3!�\e������͔��7 �,t��W����P\�xȾ,��?��A����(`�N�`癳O/Bl�+OEi�	����Q��(�,B��+��i5�	q;�\�?\w8{�Ɍ3�[�\�3݇ɍ�Z�:5p���d�~�V�3��FGQ�5�Hb;�R}�Ɛ"�^/�����*�r��2�k�"��i��4�=�IwR�ת�+TОG�H����}�DQ�Rd`��9�`�=�9��F���m���݆&��F�G�چ�tyz�C�z�ބ�(��2$��n�p	 ���I���a4v��b��*�9 X�P�D��#]c��
xA΅�� ���D!'����ݴrA�pF��@QS@�ÚlU���j6|��@��jh	D��wP�r��]ȏ9���g��E��*�7�C e5djA�堤e�J,!�e�C�Q
O򃓞�������/w�C�L�7�co�,�F�(��lzb�`���+$��[����;k&�²R�*6CW��Fq"�e�v4�1��G{f��C46��H��fxaE����ܠ�_�� �A��1��#���I8�G2������#v���GAפR������y���ky[y&�H�4��QN��X#C`��� x0�b]P&P ��*'D��75�1x���p2������TL���FU�����ɹ�����T7P1?,��2�}�'K4ʩn`j	FD⢀��ڮ|�d�bzLqx���,���A��J�Φڻ�`vB���Y��aE�ѣ]q�/l�_-�����#u��:���H��k�Q�xɪ����������̹t���M
p�v'��-�G]�]stQ���h����;��]�FF+?�|�0�@����W��      `   q  x��Wݭ�5|���
���B1,����j�NGL��p�"�y8ʗĉ�3��P1K4=�~z~ޟ/�=_����ϯ���m�"sUݟ<������������������l52ʖ4�F�����wP����4?)Iؗ��EEV�-���O�O����������	�|�z�!��5χ�E@&[���J����i�>&EvN����8�X����IR�Z��x`��r��&�[���\�iC���Z;>�y��;ҍ���j>�2Lq�}���W^�v�;�t��u� -E.g�U�������9tel�ɺ\W��
�)�� �Z9RT!J���A� [�냏����Y���*q;�";��H�����_  2u{����Q=��@;�?���q�����k92�� ;W�� �]㥚C�l�����%�fM������xl�����iƦ#� _@��vKD�N�s1����(�͉#!�^R~^��wZ l#W� �9����[�y^2A�K��+�%��ni��2�K��� P�N����B /g>9*R��J^-���,�s�±�;n� ,Vi����a�r}�" m��x:(�f��mw�
��@&��N! )�:�O!Km+�R	h�6}�����W8o��� Q�3{�n��|�����5R����o{[�x$_[|1��\c��g ���\Lp, ��(��P4�%l�U)���������P>�'㾰n8�.5>^
m�v�}�ƅ��s;��C�ӯ���#F�Y��Pv>���b ��Z��� 1��-ֆt!1i>Wc;m���M�Nv���$`{2��ˈ
� �������2��_$��y��W�}��������/G      a   R  x�M�k�d!��^���^f�똏��3�m"��Bi�d5�j��>�Dt�ԮM�x��3�gF�'�sf_m5�����G�E�졺���wg�ʳ\���޼œ1>k6Ϲt̕}�ݲBQu�j��k��~�i2+F���\���������<d��:;_~b^9'�硒��^G���妖6|k�g�z�*�79�b�_P�o�D�k�)k螽�[�r_�%�1�$��:������9��
�È�Z��H9]v�s}�^���	�{�NU�����|M����Y�����ױ΀8��D�LBm���k���/��[×t����NM朔9Ĉ�>_=57�E�ku�Nz�ϐ��,��|�+�l�շ�j:u54|��\����J��6�dsgW~?5��.$>'���f���s�,sH-t��y�]J��c�����_FLo���!Ի�ܝz5��3� 7�9=�d�mۚ�m���֯S�@
O�}Y��|��e�h��7�=7�!�37s�k7�WڗF��Ӡ!%�Ɖ�,4C`�U;}E����3qAS)�i���]s���6�êz�Xɍ�F��M��SP���6�� N+����j�����7m���3�[�W��=(
���,L�krȸ�����O^�� �\���8�_�0��*ݰ���5?�Ι�ț��)���Vе1}wgT�QՋ�^Q��D��y��"��b�b�;ї�r�=���禚]��ׅ9�D�q~�O�#�)�ŷ�^�l���!˺�Ɖ�̑�,Od��}��0��#�m�����ꩫ�R��T�r��zPr���oT2_z�E&5��5��:y'^��΀�,��k{L��l�{y�8����� �n6�6��S��B4��'lo�׼//�#�8}â�H�wq����7,z�[m٢�]Em�^�F���N�ۨ-�]��A�M�k9�4?���T��5ج�@��rmw�X6�l�~�@�8�2LrC�~p����γщ~�m{X�����0_u�ޅ�W���`|��p��˫��x?p��[<�A/�l�籥Sr+����E��l�}[JT`Gq ��p>��%�Z	�Uda��G}�q:^��PV�o�K�$���3{�/��r�,<.F������X)��8C�J 4�e=���S�4.��}�a?���%Q���U̮OF��Y`�ea�c+���Yo��p߂�P/�q����%��m_'G�H)-�W�=��� �`����Ͳ�8jѓ����傐wΒu���e��B�M���
x��b r��D���k�^�'��d����ʅv1yN.\=y �-�˯��-ʯ����޹W�;�gp���'��.Q�ki{y���������      b     x��W�n+7]}�����(���@���7��{\�Iڿ/�q�͕&�6�	>�s8���i�ݎ���:?�����$�!;���m���>O��l�/����1_�<�;7W/�e>?�����۽Z�j�E�fq?���������E��]B�fc6Rm�l��qy����o�?�"|<���Y������܏�e=?R	���M:x:����t-�V`������r~��?O�\.�r�����zZ������Ʌ��������z��]߮�eݐ����z	�Y1�y�//�S�����x�l�_Q!v��\Hi���]�12�%�2˰7��Pq� ���p�C�Y��s��Y��ۯ`\Ӣ {��l
��H6�4�V0l�A<����(�b���,����\	H��rk��ˠm�.�ǻ��na��^�G��*-��7�� VPg!RK?;�`?
�8��5�1J�	L]8RmV�j��ݨ�j���߀��%p��ı��3���1g�~kR�*�1��U+��/u�#�n���ĀF-�,"u������c|iI������1��>��EA�@u�c��/q3Uj��t�>W����{��5��|��j�ޥ�4ނ��E\"������#�ڡM��SD���oM3+��}N�$]+��bܝ2RY��� ��@��Zn�4�A�Q�d�>q�Ru CE�6��Xk�ɼ](�>��B"$���F��I������B�4�/�<�>[I2���%)�]�h+
ѱ~� d��GC��2�ak6=�{����&�2#s�B[gr��}���.'���T�Ҽ
�ϖ���v��]M�-ȥ�����:�;`�G�hƧ��2��v7Ug{��F��
�tV�'KD�;<YW4��P��m�YHA�b�q�*�|E>�GW샢tG���6EQ���3I=���q�c`�K@keX%h_C��=8eh������;J�I�8Mд�iBuT�2lplg����&?B��i���m��l��7������<y�3�����M�      c   �  x�U�ّl)D���"�"ɗ�ߎI���=�QA�I�D���k��lB���.m}a�6��1}ĺ�����(���5���T�yH�������T�!�w��϶>�5&������֧#|�͊�H϶?���)�xͪ�>��|ד�Dgj͙XR厲tF863+�`��˱��EN���Es�L��H�{"���3�xL����C���A�k���;���O���<�V�v)�Aiw��#�S.$9䞙p�j���ܸ�EZ���|�we[��f���|af�m6��֗��_ˤ�����q[�B����3!F�J�:lƻ������j�`(��7����oU����LI��+6��z�R©B�f�fǯ��r.��fG�n��I���Q�.�a�NU]!���b�|����6!*6�|�>�Qo�YT6P������Ȏ>s���+D�	2�����f;8�Dexܕ	��v(9�w_�E JR|l�[8����F#d�qt��6+�z+7��K{�$f�ܗ���L�45��V�k�m���Qu��!�1`bO�EEm�&4&��G��"�Y�"�U;�$����s��!��G��h(u���4f�gF~]ځ)���͂/�p�3�:�ٗ�I0��V�ɱ/�|c�a�>�� L���}�9VF�6B\>��9��GxL1]�tw߹WF�6)֘����a��ûy�u�]9��A�1W�~�����B��w�j;`[��<��',}y"��������6J�3ؾ�@�Q<{�$��P��|ﰶC��`�3�nf; ���{ A��A���ڽ.����`7���As����A�������߲ҽ����G"��L�0�M�+�XA���`��|{<3��P��2Y�����Qm��G�v%����nq�;ߩp#��HQ�hC^ixO�� ���
�=a��9O��AAKr��x��^�#R	������܆(���R�Ђ7�|��н}�j�q-�r�p-W�C�0�=�����,�-�D?���}�ϑ�>tR�nT?>�P���ɿ�:܈;�9���$���j��'l�e=r�F0�f�MJ��CaaT�&���Q]M'���������v��J9G�߅�T�m�� �7�p�`�����s9��r4���.&Z�Հ��B;C�����{��T��      d   �  x�U�K�#+Dǰs�������]�v⪊�Q�H�PiҖ��a�t��f�T�6m%�+��8}�|ivk��,_62�g�޽yK~"ƶ���kz�M�V��{}�&/ɾ�V�:�7�ٲq��1W}����S�H`�'�^s�j�֜k����2X�b:��s�hi�Sch}�x�E�%��R�1�b���	��աO�@�@Ɣ'�.����:��}߷XI	1B��}I"-KW�Xq9�|s7`�&|ɿ�?�9W��-����fL��l�|���]�^|"��yQ����,'�|����Z�&&C���q��m�*���9G_�EK��s�ZO���Ԉ���ʇ3�0�T�(���1���Ut�譁\`����#˟o�t���P�^:`���%������=���M�'T��I��g1����|1S��?��L[��-G�����n�r��֍M�v(iE�´>�?�D*�\%ɝ�I.E���sϟsz��;��/�.��XK׭ovG*L��5|ߙE�n�`�wj�s������##���@~m�*M,���0*"݆��vϳн�C�?���I�.H��ӿ�g5@υ��{�61����%#r>1�d6 >z���W��>�T���.��5�j��Ë�)
o@&b6��,p�h{jx0�ùn5�Է'i����`id��.w��~����$�}�4Vs`9��e�'����t{dF(�ԛV�aOJg���&��}��s��X> :����\��$�)}c~F�h_�i#�� ���;2\����]�r&	����0H,��V��^�h��x8���hG�P�5��C*0U8�>^f�%������-��1%X��Z�yF��u���LJb�(f�	��s����0���:��>&�m��
�}��zB	C��L��c]4ư���F` �J���Z�P!3��r���E���z�*�Qtla�U����X�?�q��-=�1��}�����x5���m�u�S���?�dc0'q-l�k;�ƫ�h�BG1o���_���ر�������='�>�* 2O��a�����I3d�O������U�C�g��vh�%�2�. ���3F�~ԍQ_��r:�?o<α��oc�H}'��$K�����Y?y���yH����;z�+������1V?���{�ԋ��      e   �  x�U�[�)D�u/5Gް���:&�L1���Q�T���0R�����G5y<#�}�;�?�)����ޙ�-�:����n���x�x���Y:}<#%)�-`�1�!,ľg�G�m��r6����5ޑ�u��9�FSKI��&!-2���l��̭�B(嚬�V���I�u�:��d���$���$M��;+�1>(/�Y�I9��~C�ϭє-�|M����Y��踻�����]�Yۗư񠋣��~�&�ۃ�[��Q���1$�m�^�����*��[ l���������ڍlƯC,6������`$��k����T�W�1j�>��5���G�>vq^7R�Gt4*��@ ����#�?�|\���P� ��r�i�qk,J2�]��5(�n����b���5�pB�}���Ӂ�{�!�,�A����k��Q���hܖ��O��GS�Y�՜n1������/"�p�ڍ�N��$��}��5�X(�'�}�Eimb	��UЫ�F��q6M$ݵ��aH��zYk�*�!�V�'o��WE��$���H,��=��6�� ��BW��;�撼I��m0K��b)޴�����5�����5Q�Xd~K��YGcT.r/��V�K�ߵ�d<x��e��$1�I<�r3F�h���j4EH�������Elٷ����`^������Ѡ�fZ[�w�E�E1M�ڌ��8
Iv5�3v���w��m¹Ӂ|W��;���1A�/ƶ�A)[�6ok4Y]q֏m��iTo�VF�h\��
�H4M5Z�&H|�X���P����1��=�z��i�a^�Eu(��t��P��!Q��:��@/v=�,j�!pCug�|�n�^5�>��ķ����_���`g���G~��!�I��x._�-���F��N5��,D� �n����h���$��Y$�!�$�//2��«�W�����?￐�cX�������      f   �  x�UXiO���|=�˱��g$X �&�7�Nb'�I�r|���?��GZ�K��������(ʲ($ՠ����~�p��6�s��Jv����0��?>�Ä��n��cR�Y3�5B�[�h&�/�!O��t�����Ռ�d(�q��R�h �V���f�6J3+-�wl6�����w.���� �Ney���Z��>�\�"JHJz[���� ݞ�{�r�I�3�#Cr�n�)1�P�s�%Hz$��7w�����W�"�0n��E��pL�5�j#(��t�������hj�;J�(M�I��Kxh�D��3&���'�C�z�Y�n�����!�A��4��A��9΍�Ijz*ݐw�d9�[��ݧ�%�A7D6��cB����JP�H��_�W���.�£>9r�Ј2�Պ�`JLcb���������A�im�h��(%�0��݀Ԓ�1"F(i)�LiIz�z�sg�^?�|G�?�y��� ���F�A_3���@�O��ۙ;���:��w��I#hEAF��hI�d�̧FR�I~Ng�s��|s�m�j=���C�1�AJ�V���熤gz��^�7�q��>K�'��d;�s��(��B��όV�[nI\����gSv�n��;��J�.Rv�4 ��׀�/,�/�����q�-�F��<�;x%��R!��#��k�~�������tO��T_�4d7����N��9�<
��ڵ�N�j�����`P�ߡ����>��d�h�GZe%�J���H��:s�}�����Ͼ㨃^��<J��J��n�nti?��vQ(���V��������R����*�����g�>��g���0��0�Nj-VN�QY�4��ӗ��P�# ������! �c?V�=����{<<OGkŪ�	r>;|��I�젟8e�J.H�Ʈm,����c��a7�T�A���h�0���1�3�y�4w3:)�"�"�A�U������TqŔ�K�ˎ}h]�v��GS�.������4��m��2��T�̛Y;��he}kK0+3hG#�(#�%�D�|�$�>i�_Yei��o+�1X����)��V@8��,(�ZP޵�>6�����ل��I<�<��HR	G٘���TR�?#IEO�S[i�l*��j�O���`����a�S]r��2�[k����;@�\��a�T�<��� �;0+��5(̟�i<G����⍾�8w|�:yðP�ia�$gjj����<�N�v��'o�A'��X.a_���]^l��m�?���J���Q���@9� �'�1dP�k�[�����!���[A@�a�J-��K_ャ+�����?+�C׸�� E�f���M��(�d]�ٳ��mw�0�}x-� ��$i��"i!��R�b��?�����	8 c0�N�L�I{`��÷�~Z��2�_����h9�H��c���JY�c�ǧ�mu������xe��X	J��~3A���� h�B@)x㶙����{�B�������� �VD�XQ��e����ۅlhOpR��X5���6�/+i'�-��z�pW+���P������4ỷrtL!��z�Z㳿�f
 �$���(H[n?��/m�)�\��l�����Ow���@/^�@��(v�hb�������\8������|X*��4H5M�~?D`�s%�cփ}�q8�_ޜ=<�IZ؉�4@�c��W@�!l�$<������p��lQ#��� �Qx�o�1>�p���YJTMf�O���>0��Ϛ��(M���j* �PH�HP��_�Esy2}p͖'4N���w��!ۃ~֋�r%J�h�/�kr�6/��y������1vq�{c$�U*F�5�Vz�o�LM7�EB�q�"�H9۰�pj�RZ��=e+��G����`;���x�v&�f��&��@�!��y��Í㗂�}OJ� ������ ƶj	倎�d|�V/f�����ۣ��Y�W�Au�(�ki��Zɤ�4+�����v�/��?�#5(�_� �MG��b�l0�ry<aS��pvi��7��O�{/��!})@�\�)�GJ� �y��V*i��oGI�������/9����'ϷzF��zW(���O�і�I?�����_e�]I�#ݚڸ���LZT�<E�P:��i����aL����H�W������p���9�ڰ�����ڀr�U����|y�i�vo�2<��"L�-�� � A��
v�y��vw�O5��:7���G1X�Yg����F/6���E%�E��ᵡ�Ȉj*]۝���噣��ũ����b	�� 4!���Y��F*�k�|��z}s�؎*[տ���L<�49�� f��b�?4�J+a]�b��ӛ�b�j�s�wY���<s#�	�]��P��IX�������eA�x�%�I�<�Q��p���1�"�^���$v�h����{6u
)!q臆US�ukf��+�A���&u��m)�n�y>��z6��<������c)-���v����ݭ�E��<����5� 7A���6�]7/[l�c���~�O6c�P�� ��	^��0s�(�)m�|4��Cߖ�V����_/���}x��6p�b�y꜉���!:�E|���7�l1�V0��^��j ��3��I�Xb�s���F�ze�
�Қ�a+�u��JS�#L�@�����pfy�fq�|:�;�����x���lSg �e�4_��'Ǵ^��<����6�� �Al��]ntƑō��C�^��~pu��p]��t'��he%LG4@  0B�,K��bio�T+@B=�i�v�i����*���K�ti�6v
c�=��A:t��<�FI
�c���S8���'͛�RY4��m��8ڲ,�'���*@��Oq+����m��^�*��n�R�~�X&k���+���J��{w������3�l�A�r���rM�&�d�ff?\��7j��,���'��������W�Y�7^�����~�k�e_q0E�#qo�e*pH�V�Bo5~���JA:�6+�W� +�_�X�*�z&gւW���SA�h$�_�*w���d:����@T�v�Lca���<x�
���m�y1L:�oH���9��vӵ����X-���A+I]YQ���+TkE�Dw)y��l�_��	����U }�#�j���jAZ��1o��'t�~px_�ɸ����?_����Ø_����EIť�g;id�
����s�_t����c}��;Oį���������דA�N����]�A?j�0X-�<��4������`=�@����\/��K0�gA��˥���rA,pm{�z�Y�b��8���<������p&$��/�t[����lL��R�Y��1.����
q: =�x�'>u�nV'� =[K��8L�d{�;$cCA^���^ӷ�{��������%�iWA��CXW�d�ˠ_�w�b������y��~`c     