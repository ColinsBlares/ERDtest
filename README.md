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
call test.add_resident_to_apartment('Иванов Иван Иванович', '1999-05-01', '2024-04-16', '+7999999999', 3);
```
>Добавляем пользователя ```Иванов Иван Иванович``` у корого дата рождения ```1999-05-01```, дата регистрации ```2024-04-16```, номер телефона ```2024-04-16``` в квартиру с id ```3```

> [!CAUTION]
> Это не может выполнить обычный пользователь.

2. Получение информации о жильце
```sql
call test.get_resident_details(2);
```
>Получаем информацию о жильце с ID ```2```

3. 
