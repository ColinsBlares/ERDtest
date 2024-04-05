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
