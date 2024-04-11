![Скриншот](https://github.com/ColinsBlares/cource_work/assets/118037471/6cceeffd-99dc-4885-92c3-4a723fa26635)

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
    r.birth_date, 
    r.phone_number,
    COUNT(ahr.apartments_id) AS NumberOfApartments
FROM housing.residents r
JOIN housing.apartments_has_residents ahr ON r.id = ahr.residents_id
JOIN housing.apartments a ON ahr.apartments_id = a.id
JOIN housing.buildings b ON a.buildings_id = b.id
GROUP BY r.id, b.addres, r.full_name, r.birth_date, r.phone_number
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
