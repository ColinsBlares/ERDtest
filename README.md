**Типовые запросы**
1. Квартиры в одном доме и их владельцы
```sql
SELECT buildings.address, apartments.id AS apartment_id, residents.fullname
FROM buildings
JOIN apartments ON buildings.id = apartments.buildings_id
JOIN apartments_has_residents ON apartments.id = apartments_has_residents.apartments_id
JOIN residents ON apartments_has_residents.residents_id = residents.id
WHERE buildings.id = 1; -- Замените ? на идентификатор здания
```

2. Получение платежей между датами
```sql
SELECT apartments.id AS apartment_id, SUM(payments.amount) AS total_payments
FROM payments
JOIN apartments ON payments.apartments_id = apartments.id
WHERE payments.date BETWEEN '2024-01-01' AND '2024-04-04' -- Замените ? на начальную и конечную дату периода
GROUP BY apartments.id;
```

4. Узнать квартиры без владельцев
```sql
SELECT apartments.id AS apartment_id, buildings.address
FROM apartments
JOIN buildings ON apartments.buildings_id = buildings.id
LEFT JOIN apartments_has_residents ON apartments.id = apartments_has_residents.apartments_id
WHERE apartments_has_residents.residents_id IS NULL;
```
5. Обновить телефон владельца квартиры
```sql
UPDATE residents
SET phoneNumber = "+79528120321"
WHERE id = 2;
```

7. Показать машину с парковочным место и описанием
```sql
SELECT carspots.id AS carspot_id, residents.fullname, car.carPlate, carspots.description
FROM carspots
JOIN residents ON carspots.residents_id = residents.id
JOIN car ON carspots.car_id = car.id;
```
