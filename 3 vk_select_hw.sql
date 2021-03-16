/* Задача 1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, 
который больше всех общался с нашим пользователем. */

use vk;

select 
	from_user_id, 
	count(*) cnt
from messages m
where to_user_id = 1
AND from_user_id in (
  select initiator_user_id from friend_requests where (target_user_id = 1) and status='approved'
  union
  select target_user_id from friend_requests where (initiator_user_id = 1) and status='approved'
)
group by from_user_id
order by cnt desc
limit 1;


/* Задача 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.*/

select count(*)
from likes
where media_id in ( 
	select id 
	from media 
	where user_id in ( 
		select 
			user_id
		from profiles as p
		where  YEAR(CURDATE()) - YEAR(birthday) < 10
	)
);
 

/* Задача 3. Определить кто больше поставил лайков (всего): мужчины или женщины.*/

select 
	gender,
	count(*)
from (
	select 
		user_id as user,
		(
			select gender 
			from vk.profiles
			where user_id = user
		) as gender
	from likes
) as dummy
group by gender;





