USE sakila;

select * from film;

-- Liệt kê tên các phim (title) có độ dài (length) lớn hơn 120 phút.
SELECT title, length
FROM film
WHERE length >= 120;

--  Hiển thị tên và độ dài của những phim có độ dài trong khoảng từ 90 đến 120 phút, và rating là 'PG' hoặc 'G'.
select title, length, rating
from film
where length between 90 and 120 and rating in ('PG','G');

--  Liệt kê 10 phim có độ dài dài nhất, hiển thị title và length, sắp xếp giảm dần theo độ dài.
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;

--  Liệt kê tên khách hàng (first_name, last_name) và địa chỉ thành phố của họ (city) bằng cách kết hợp các bảng customer, address, và city.
select c.first_name, c.last_name, ct.city
from customer c
join address a on c.address_id = a.address_id
join city ct on ct.city_id = a.city_id;

--  Liệt kê danh sách các quốc gia (country) có nhiều hơn 10 khách hàng.
select co.country, count(*) as soluongkhachhang
from customer c
join address a on a.address_id = c.address_id
join city ct on ct.city_id = a.city_id
join country co on co.country_id = ct.country_id
group by co.country
having count(*) > 10;

--  Hiển thị tên thể loại (name) và số lượng phim thuộc thể loại đó. Sắp xếp kết quả theo số lượng phim giảm dần.
SELECT c.name AS the_loai, COUNT(*) AS so_luong_phim
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY so_luong_phim DESC;

-- Liệt kê tên khách hàng và số lượng phim họ đã thuê. Chỉ hiển thị khách hàng có số lượt thuê từ 30 trở lên.
SELECT cu.first_name, cu.last_name, COUNT(*) AS so_luot_thue
FROM customer cu
JOIN rental r ON cu.customer_id = r.customer_id
GROUP BY cu.customer_id, cu.first_name, cu.last_name
HAVING COUNT(*) >= 30
ORDER BY so_luot_thue DESC;

-- Tính tổng doanh thu (tiền thuê) theo thành phố (city). Chỉ hiển thị các thành phố có doanh thu lớn hơn $500.
SELECT ci.city, SUM(p.amount) AS tong_doanh_thu
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN customer cu ON r.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city
HAVING SUM(p.amount) > 500
ORDER BY tong_doanh_thu DESC;

-- Liệt kê 5 phim có số lượng diễn viên nhiều nhất. Hiển thị tên phim và số lượng diễn viên.
SELECT f.title, COUNT(*) AS so_luong_dien_vien
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title
ORDER BY so_luong_dien_vien DESC
LIMIT 5;

-- Liệt kê mỗi thể loại phim và thành phố, kèm theo tổng doanh thu từ việc thuê phim thuộc thể loại đó tại thành phố tương ứng
SELECT c.name, ci.city, SUM(p.amount) AS Tong_doanh_thu
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN customer cu ON p.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY c.name, ci.city
HAVING SUM(p.amount) > 100
ORDER BY SUM(p.amount) DESC;

-- Liệt kê số tiền thanh toán theo từng nhân viên và thời điểm trong ngày (sáng, trưa, chiều, tối)
select staff_id,  
case
	WHEN HOUR(payment_date) BETWEEN 6 AND 11 THEN 'Sáng'
	WHEN HOUR(payment_date) BETWEEN 12 AND 13 THEN 'Trưa'
	WHEN HOUR(payment_date) BETWEEN 14 AND 17 THEN 'Chiều'
	WHEN HOUR(payment_date) BETWEEN 18 AND 23 THEN 'Tối'
	WHEN HOUR(payment_date) BETWEEN 0 AND 5 THEN 'Đêm'
end as time_slot,
sum(amount) as total
from payment
group by staff_id, time_slot
order by staff_id, total desc;

-- Liệt kê tất cả khách hàng có thanh toán thành công, kèm theo
select c.customer_id, concat((c.first_name), ' ', (c.last_name)) as full_name, sum(p.amount) as total,
CASE 
	WHEN SUM(p.amount) > 200 THEN 'VIP'
	WHEN SUM(p.amount) > 100 THEN 'Tiềm năng'
	ELSE 'Mới'
END AS status
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
having sum(p.amount) > 0
order by total desc;

-- Liệt kê các phim hiện có trong kho của từng cửa hàng
SELECT s.store_id, f.film_id, f.title AS film_title,
CASE
	WHEN r.rental_id IS NOT NULL AND r.return_date IS NULL THEN 'Đang cho thuê'
	ELSE 'Có sẵn'
END AS stock_status
FROM inventory i
JOIN film f ON i.film_id = f.film_id
JOIN store s ON i.store_id = s.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL;

-- Phần 1 – Index
-- Bài 1: Tạo chỉ mục cho việc tìm kiếm
-- Tạo một chỉ mục trên cột first_name của bảng customer. Sau đó thực hiện truy vấn tìm kiếm khách hàng có họ là 'WILLIAMS'. So sánh thời gian truy vấn trước và sau khi tạo chỉ mục.


-- Bài 2: Tạo chỉ mục kết hợp
-- Tạo một chỉ mục kết hợp trên hai cột store_id và last_name trong bảng customer. Gợi ý: sử dụng CREATE INDEX.


-- Bài 3: Chỉ mục và sắp xếp
-- Truy vấn danh sách khách hàng theo last_name sắp xếp tăng dần. Sau đó tạo chỉ mục phù hợp để cải thiện tốc độ sắp xếp.


-- Phần 2 – Stored Procedure
-- Bài 4: Procedure không có tham số
-- Tạo một stored procedure có tên sp_list_actors để liệt kê tất cả diễn viên trong bảng actor.


-- Bài 5: Procedure có tham số IN
-- Viết procedure sp_rental_by_customer nhận vào customer_id và hiển thị toàn bộ các lần thuê của khách hàng này.
DELIMITER //
create procedure sp_rental_by_customer (in p_customer_id int)
begin
	select *
    from rental
    where customer_id = p_customer_id;
end
DELIMITER ;

CALL sp_rental_by_customer(5);

-- Bài 6: Procedure có tham số OUT
-- Tạo procedure sp_total_payment nhận vào customer_id, trả ra tổng số tiền đã thanh toán (từ bảng payment) qua tham số OUT.


-- Phần 3 – View
-- Bài 7: Tạo View đơn giản
-- Tạo view v_film_short_info gồm title, description, release_year từ bảng film.


-- Bài 8: Tạo View có JOIN
-- Tạo view v_customer_payment hiển thị customer_id, first_name, last_name, amount, payment_date từ bảng customer kết hợp với payment.


-- Bài 9: Tạo View có WITH CHECK OPTION
-- Tạo view v_active_customers chứa khách hàng có trạng thái active = 1. Dùng WITH CHECK OPTION để ngăn cấm thay đổi active thông qua view thành giá trị không hợp lệ.






















