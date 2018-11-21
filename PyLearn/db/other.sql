update obtain_earning_info set earning = round(earning - 0.01, 2), remark = 'obtain_earning_info sub 1 min' where username = 'mario_84393FAS3Q'  and id = (select id from  (select min(id) id from obtain_earning_info where username = 'mario_84393FAS3Q') tmp );
update obtain_earning_info set earning = round(earning + 0.01, 2), remark = 'obtain_earning_info add 1 min' where username = 'mario_6K4Q06264T'  and id = (select id from  (select min(id) id from obtain_earning_info where username = 'mario_6K4Q06264T') tmp );




