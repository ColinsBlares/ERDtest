![Скриншот]([https://cdn.discordapp.com/attachments/1218231417465606184/1225890706137288785/image.png?ex=6622c6b0&is=661051b0&hm=b556d3e9893ef690bbca4451255f0801dde3348cdc48b5270ec6ca543e89c7c5&](https://media.discordapp.net/attachments/1218231417465606184/1226931676999843960/workingVar.png?ex=6626902b&is=66141b2b&hm=8ffa7cba6d03cc4bedfcf50fff7b43e0ec7cb03b44b15673d0d1d5d7f96a210d&=&format=webp&quality=lossless))

> [!NOTE]
> Пока что все в разработке.
> 
**Типовые запросы**

1. Получить список всех квартир с их площадью и количеством комнат
```sql
SELECT id AS ApartmentID, rooms AS NumberOfRooms, area AS AreaInSqM
FROM housing.apartments
ORDER BY rooms, area;
```

2. Получить информацию о всех жителях определенного здания
```sql
SELECT 
    b.addres, 
    r.full_name, 
    r.dirth_date, 
    r.phone_number,
    COUNT(ahr.apartments_id) AS NumberOfApartments
FROM housing.residents r
JOIN housing.apartments_has_residents ahr ON r.id = ahr.residents_id
JOIN housing.apartments a ON ahr.apartments_id = a.id
JOIN housing.buildings b ON a.buildings_id = b.id
GROUP BY r.id, b.addres, r.full_name, r.dirth_date, r.phone_number
ORDER BY NumberOfApartments DESC, r.full_name; 

```

3. Подсчитать количество квартир, владельцы которых имеют автомобиль
```sql
SELECT COUNT(DISTINCT a.id) AS ApartmentsWithCarOwners
FROM housing.apartments a
JOIN housing.apartments_has_residents ahr ON a.id = ahr.apartments_id
JOIN housing.residents_has_car rhc ON ahr.residents_id = rhc.residents_id;
```
4. Список платежей по квартире за определенный меся
```sql
SELECT a.id AS ApartmentID, p.date AS PaymentDate, p.amount AS Amount, p.type AS PaymentType
FROM housing.payments p
JOIN housing.apartments a ON p.apartments_id = a.id
WHERE MONTH(p.date) = 3 AND YEAR(p.date) = 2024; -- Пример для марта 2024

```

5. Вывести информацию о наличии кладовых у квартир
```sql
SELECT a.id AS ApartmentID, IF(ISNULL(s.id), 'Нет', 'Да') AS StoreroomAvailable
FROM housing.apartments a
LEFT JOIN housing.storerooms s ON a.id = s.apartments_id
ORDER BY ApartmentID;
```
