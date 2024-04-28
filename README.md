![Скриншот](https://cdn.discordapp.com/attachments/1218231417465606184/1227886700638900336/ss.png?ex=662a099a&is=6617949a&hm=8beb6b12ae1d0733fb6c9156133f479fb2dd7e5f6cd538c19e71679df11f56b2&)
- [x] Минимум пять связанных таблиц
- [ ] минимум две отдельные роли (хотя бы одну кроме роли администратора)
- [x] минимум пять типовых запросов к БД
- [x] минимум одну транзакцию
- [x] минимум три локальных переменных с заданным типом данных
- [x] минимум одно условие
- [x] минимум одну хранимую процедуру
- [x] минимум одно представление
- [x] минимум один триггер
- [x] минимум одну пользовательскую функцию
- [x] минимум один обработчик исключений

> [!NOTE]
> Со временем все может измениться.
>

# Типовые запросы

1. Получить список всех квартир с их площадью и количеством комнат
```sql
SELECT id AS ApartmentID, rooms AS NumberOfRooms, area AS AreaInSqM
FROM apartments
ORDER BY rooms, area;
```

2. Получить информацию о жителях и их квартирах
```sql
SELECT 
    b.addres, 
    r.full_name, 
    r.birth_date, 
    r.phone_number,
    COUNT(ahr.apartments_id) AS NumberOfApartments
FROM residents r
JOIN apartments_has_residents ahr ON r.id = ahr.residents_id
JOIN apartments a ON ahr.apartments_id = a.id
JOIN buildings b ON a.buildings_id = b.id
GROUP BY r.id, b.addres, r.full_name, r.birth_date, r.phone_number
ORDER BY NumberOfApartments DESC, r.full_name; 

```

3. Подсчитать количество квартир, владельцы которых имеют автомобиль
```sql
SELECT COUNT(DISTINCT a.id) AS ApartmentsWithCarOwners
FROM apartments a
JOIN apartments_has_residents ahr ON a.id = ahr.apartments_id
JOIN residents_has_car rhc ON ahr.residents_id = rhc.residents_id;
```
4. Список платежей по квартире за определенный месяц
```sql
SELECT a.id AS ApartmentID, p.date AS PaymentDate, p.amount AS Amount, p.type AS PaymentType
FROM payments p
JOIN apartments a ON p.apartments_id = a.id
WHERE MONTH(p.date) = 3 AND YEAR(p.date) = 2024; -- Пример для марта 2024

```

5. Вывести информацию о наличии кладовых у квартир
```sql
SELECT a.id AS ApartmentID, IF(ISNULL(s.id), 'Нет', 'Да') AS StoreroomAvailable
FROM apartments a
LEFT JOIN storerooms s ON a.id = s.apartments_id
ORDER BY ApartmentID;
```

# Хранимые процедуры

1. Добавление жильца в квартиру
```sql
call add_resident_to_apartment('Иванов Иван Иванович', '1999-05-01', '2024-04-16', '+7999999999', 3);
```
>Добавляем пользователя ```Иванов Иван Иванович``` у корого дата рождения ```1999-05-01```, дата регистрации ```2024-04-16```, номер телефона ```2024-04-16``` в квартиру с id ```3```

> [!CAUTION]
> Это может выполнить ТОЛЬКО роль администратор (admin_role).

2. Получение информации о жильце
```sql
call get_resident_details(2);
```
> [!CAUTION]
> Это может выполнить ТОЛЬКО роль администратор (admin_role).

>Получаем информацию о жильце с ID ```2```

# Представление

Получение сводки со всех таблиц
```sql
SELECT * FROM residents_apartments_view;
```
> [!CAUTION]
> Это может выполнить ТОЛЬКО роль администратор (admin_role).


# Функция
Получить сумму всех платежей между датами
```sql
select GetTotalPaymentsByResident(1, '2020-01-01', '2024-04-28');
```
> [!CAUTION]
> Это может выполнить ТОЛЬКО роль администратор (admin_role).

> Получаем сумму платежей жильца с id `1` за промежуток с `2020-01-01` до `2024-04-28`


# Создание ролей и прав

1. Роль "Рядовой пользователь"
> создание пользователя `user` с паролем `123` 
```sql
-- создание роли
CREATE ROLE IF NOT EXISTS basic_user_role; 

-- присвоение прав
GRANT SELECT ON housing.buildings TO basic_user_role;
GRANT SELECT ON housing.apartments TO basic_user_role;
GRANT SELECT ON housing.residents TO basic_user_role;
GRANT SELECT ON housing.car TO basic_user_role;
GRANT SELECT ON housing.carspots TO basic_user_role;
GRANT SELECT ON housing.storerooms TO basic_user_role;
GRANT SELECT ON housing.payments TO basic_user_role;
GRANT SELECT ON housing.apartments_has_residents TO basic_user_role;
GRANT SELECT ON housing.residents_has_car TO basic_user_role;
GRANT SELECT ON housing.payments_has_residents TO basic_user_role;

-- создание пользователя, если он еще не существует
CREATE USER IF NOT EXISTS 'user'@'localhost' IDENTIFIED BY '123';

-- назначение роли пользователю
GRANT basic_user_role TO 'user'@'localhost';
-- активация роли для пользователя
SET DEFAULT ROLE basic_user_role TO 'user'@'localhost';
-- применение изменений прав
FLUSH PRIVILEGES;
```
2. Роль "Модератор" 
> создание пользователя `moderator` с паролем `123` 
```sql
-- создание роли
CREATE ROLE IF NOT EXISTS moderator_role; 

-- присвоение прав
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.buildings TO moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.apartments TO moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.residents TO moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.car TO moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.carspots TO moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.storerooms TO moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.payments TO moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.apartments_has_residents TO moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.residents_has_car TO moderator_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON housing.payments_has_residents TO moderator_role;

-- создание пользователя, если он еще не существует
CREATE USER IF NOT EXISTS 'moderator'@'localhost' IDENTIFIED BY '123';

-- назначение роли пользователю
GRANT moderator_role TO 'moderator'@'localhost';

-- активация роли для пользователя
SET DEFAULT ROLE moderator_role TO 'moderator'@'localhost';

-- применение изменений прав
FLUSH PRIVILEGES;
```
3. Роль "Администратор"
```sql
-- создание роли
CREATE ROLE IF NOT EXISTS admin_role; 

-- Предоставление полных прав администратору на схему housing
GRANT ALL PRIVILEGES ON housing.* TO admin_role;

-- создание пользователя, если он еще не существует
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY '123';

-- назначение роли пользователю
GRANT admin_role TO 'admin'@'localhost';

-- активация роли для пользователя
SET DEFAULT ROLE admin_role TO 'admin'@'localhost';

-- применение изменений прав
FLUSH PRIVILEGES;
``` 
