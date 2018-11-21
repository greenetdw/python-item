update obtain_earning_info set earning = round(earning - 0.01, 2), remark = 'obtain_earning_info sub 1 min' where username = 'mario_8RIC0519P6'  and id = (select id from  (select min(id) id from obtain_earning_info where username = 'mario_8RIC0519P6') tmp );
update obtain_earning_info set earning = round(earning - 0.01, 2), remark = 'obtain_earning_info sub 1 min' where username = 'mario_8B391W719F'  and id = (select id from  (select min(id) id from obtain_earning_info where username = 'mario_8B391W719F') tmp );
update obtain_earning_info set earning = round(earning - 0.01, 2), remark = 'obtain_earning_info sub 1 min' where username = 'mario_K44V1ZZ7Z3'  and id = (select id from  (select min(id) id from obtain_earning_info where username = 'mario_K44V1ZZ7Z3') tmp );
update obtain_earning_info set earning = round(earning - 0.01, 2), remark = 'obtain_earning_info sub 1 min' where username = 'mario_8DFHIA6814'  and id = (select id from  (select min(id) id from obtain_earning_info where username = 'mario_8DFHIA6814') tmp );
update obtain_earning_info set earning = round(earning - 0.01, 2), remark = 'obtain_earning_info sub 1 min' where username = 'mario_86348Y28M5'  and id = (select id from  (select min(id) id from obtain_earning_info where username = 'mario_86348Y28M5') tmp );


update obtain_earning_info set earning = 0.20, remark = 'old value : 1.00 , new value: 0.20' where id = 11764;
insert into obtain_earning_info(type, task_id, workflow_id, task_type, task_type_item, data_id, username,operate, earning,remark, create_user, create_time) values (0, 17618, 32333, 1, 1, 136700, 'mario_8O77R9X842', 1, 0.80, 'old value: 1.00, new value: 0.20, old_obtain_id = 11764', 'auditor_10', '2018-06-07 13:55:02');

update obtain_earning_info set earning = 2.00, remark = 'old value : 2.00 , new value: 2.00' where id = 277093;
insert into obtain_earning_info(type, username,aoi_guid,operate, earning,remark, create_user, create_time) values (3, 'mario_8G4U797912','62556EABDFD41B9DE0530EF4520A0CFC', 1, 0.00, 'old value: 2.00, new value: 2.00, old_obtain_id = 277093', 'system', '2018-06-24 09:47:34.179');
update earning_tocash_info set cutoff_earning_id = 277093 , status = 1 where id = 161 and username = 'mario_8G4U797912';
update earning_tocash_info set status = 1 where id < 161 and username = 'mario_8G4U797912' ;

update obtain_earning_info set earning = 0.10, remark = 'old value : 1.00 , new value: 0.10' where id = 15582;
insert into obtain_earning_info(type, task_id, workflow_id, task_type, task_type_item, data_id, username,operate, earning,remark, create_user, create_time) values (0, 52150, 334, 2, 1, 1403, 'mario_84Y9Y784V5', 1, 0.90, 'old value: 1.00, new value: 0.10, old_obtain_id = 15582', 'auditor_18', '2018-06-09 10:45:00');
update earning_tocash_info set cutoff_earning_id = 15582 , status = 1 where id = 7 and username = 'mario_84Y9Y784V5';
update earning_tocash_info set status = 1 where id < 7 and username = 'mario_84Y9Y784V5' ;

update obtain_earning_info set earning = 2.60, remark = 'old value : 4.00 , new value: 2.60' where id = 259268;
insert into obtain_earning_info(type, task_id, workflow_id, task_type, task_type_item, data_id, username,operate, earning,remark, create_user, create_time) values (1, 100049, 24450, 1, 2, 187493, 'mario_K4M92166NM', 1, 1.40, 'old value: 4.00, new value: 2.60, old_obtain_id = 259268', 'auditor_15', '2018-06-21 14:20:00');
update earning_tocash_info set cutoff_earning_id = 259268 , status = 1 where id = 99 and username = 'mario_K4M92166NM';
update earning_tocash_info set status = 1 where id < 99 and username = 'mario_K4M92166NM' ;

update obtain_earning_info set earning = 0.80, remark = 'old value : 1.00 , new value: 0.80' where id = 15384;
insert into obtain_earning_info(type, task_id, workflow_id, task_type, task_type_item, data_id, username,operate, earning,remark, create_user, create_time) values (0, 49159, 51, 2, 1, 178, 'mario_A4398BG39M', 1, 0.20, 'old value: 1.00, new value: 0.80, old_obtain_id = 15384', 'auditor_15', '2018-06-08 17:15:00');

update obtain_earning_info set earning = 0.90, remark = 'old value : 1.00 , new value: 0.90' where id = 16040;
insert into obtain_earning_info(type, task_id, workflow_id, task_type, task_type_item, data_id, username,operate, earning,remark, create_user, create_time) values (0, 49219, 1587, 2, 1, 6943, 'mario_8R39251X47', 1, 0.10, 'old value: 1.00, new value: 0.90, old_obtain_id = 16040', 'auditor_18', '2018-06-09 15:30:00');


update earning_tocash_info set cutoff_earning_id = 20442 , status = 1 where id = 19 and username = 'mario_8O77R9X842';
update earning_tocash_info set status = 1 where id < 19 and username = 'mario_8O77R9X842' ;

update earning_tocash_info set cutoff_earning_id = 288614 , status = 1 where id = 133 and username = 'mario_T3578O5015';
update earning_tocash_info set status = 1 where id < 133 and username = 'mario_T3578O5015' ;

update earning_tocash_info set cutoff_earning_id = 300752 , status = 1 where id = 178 and username = 'mario_8697CDK379';
update earning_tocash_info set status = 1 where id < 178 and username = 'mario_8697CDK379' ;

update earning_tocash_info set cutoff_earning_id = 292886 , status = 1 where id = 134 and username = 'mario_8V6AJ0X85P';
update earning_tocash_info set status = 1 where id < 134 and username = 'mario_8V6AJ0X85P' ;

update earning_tocash_info set cutoff_earning_id = 257662 , status = 1 where id = 141 and username = 'mario_B6SGS3Y98B';
update earning_tocash_info set status = 1 where id < 141 and username = 'mario_B6SGS3Y98B' ;

update earning_tocash_info set cutoff_earning_id = 295624 , status = 1 where id = 168 and username = 'mario_8B23M58985';
update earning_tocash_info set status = 1 where id < 168 and username = 'mario_8B23M58985' ;

update earning_tocash_info set cutoff_earning_id = 246387 , status = 1 where id = 101 and username = 'mario_MO39044QA1';
update earning_tocash_info set status = 1 where id < 101 and username = 'mario_MO39044QA1' ;

update earning_tocash_info set cutoff_earning_id = 303867 , status = 1 where id = 199 and username = 'mario_V4390YMOQ5';
update earning_tocash_info set status = 1 where id < 199 and username = 'mario_V4390YMOQ5' ;

update earning_tocash_info set cutoff_earning_id = 295161 , status = 1 where id = 140 and username = 'mario_84P91B8554';
update earning_tocash_info set status = 1 where id < 140 and username = 'mario_84P91B8554' ;

update earning_tocash_info set cutoff_earning_id = 258325 , status = 1 where id = 169 and username = 'mario_8OX34X7658';
update earning_tocash_info set status = 1 where id < 169 and username = 'mario_8OX34X7658' ;

update earning_tocash_info set cutoff_earning_id = 302798 , status = 1 where id = 192 and username = 'mario_I4XMF258R7';
update earning_tocash_info set status = 1 where id < 192 and username = 'mario_I4XMF258R7' ;

update earning_tocash_info set cutoff_earning_id = 254243 , status = 1 where id = 170 and username = 'mario_84F9T2EL58';
update earning_tocash_info set status = 1 where id < 170 and username = 'mario_84F9T2EL58' ;

update earning_tocash_info set cutoff_earning_id = 302397 , status = 1 where id = 186 and username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = 1 where id < 186 and username = 'mario_Y6ECDQUQ85' ;

update earning_tocash_info set cutoff_earning_id = 259021 , status = 1 where id = 148 and username = 'mario_86348Y28M5';
update earning_tocash_info set status = 1 where id < 148 and username = 'mario_86348Y28M5' ;

update earning_tocash_info set cutoff_earning_id = 296220 , status = 1 where id = 155 and username = 'mario_8DFHIA6814';
update earning_tocash_info set status = 1 where id < 155 and username = 'mario_8DFHIA6814' ;

update earning_tocash_info set cutoff_earning_id = 295175 , status = 1 where id = 163 and username = 'mario_84RLZAR505';
update earning_tocash_info set status = 1 where id < 163 and username = 'mario_84RLZAR505' ;

update earning_tocash_info set cutoff_earning_id = 255973 , status = 1 where id = 84 and username = 'mario_OHK91V5W9P';
update earning_tocash_info set status = 1 where id < 84 and username = 'mario_OHK91V5W9P' ;

update earning_tocash_info set cutoff_earning_id = 277841 , status = 1 where id = 154 and username = 'mario_JTTK2C55DO';
update earning_tocash_info set status = 1 where id < 154 and username = 'mario_JTTK2C55DO' ;

update earning_tocash_info set cutoff_earning_id = 250345 , status = 1 where id = 69 and username = 'mario_8IU37UKLM3';
update earning_tocash_info set status = 1 where id < 69 and username = 'mario_8IU37UKLM3' ;

update earning_tocash_info set cutoff_earning_id = 301731 , status = 1 where id = 183 and username = 'mario_8623455NXZ';
update earning_tocash_info set status = 1 where id < 183 and username = 'mario_8623455NXZ' ;

update earning_tocash_info set cutoff_earning_id = 296243 , status = 1 where id = 152 and username = 'mario_Q4393GT264';
update earning_tocash_info set status = 1 where id < 152 and username = 'mario_Q4393GT264' ;

update earning_tocash_info set cutoff_earning_id = 221022 , status = 1 where id = 42 and username = 'mario_G439YA4LBJ';
update earning_tocash_info set status = 1 where id < 42 and username = 'mario_G439YA4LBJ' ;

update earning_tocash_info set cutoff_earning_id = 257024 , status = 1 where id = 184 and username = 'mario_E6W3M789NG';
update earning_tocash_info set status = 1 where id < 184 and username = 'mario_E6W3M789NG' ;

update earning_tocash_info set cutoff_earning_id = 256955 , status = 1 where id = 144 and username = 'mario_8U23A24531';
update earning_tocash_info set status = 1 where id < 144 and username = 'mario_8U23A24531' ;

update earning_tocash_info set cutoff_earning_id = 140307 , status = 1 where id = 53 and username = 'mario_P62SCH7R89';
update earning_tocash_info set status = 1 where id < 53 and username = 'mario_P62SCH7R89' ;

update earning_tocash_info set cutoff_earning_id = 277260 , status = 1 where id = 145 and username = 'mario_J5OPKJ3C61';
update earning_tocash_info set status = 1 where id < 145 and username = 'mario_J5OPKJ3C61' ;

update earning_tocash_info set cutoff_earning_id = 299779 , status = 1 where id = 179 and username = 'mario_J6AY40P9SM';
update earning_tocash_info set status = 1 where id < 179 and username = 'mario_J6AY40P9SM' ;

update earning_tocash_info set cutoff_earning_id = 263263 , status = 1 where id = 151 and username = 'mario_843YE311JQ';
update earning_tocash_info set status = 1 where id < 151 and username = 'mario_843YE311JQ' ;

update earning_tocash_info set cutoff_earning_id = 246421 , status = 1 where id = 45 and username = 'mario_84DT17GULR';
update earning_tocash_info set status = 1 where id < 45 and username = 'mario_84DT17GULR' ;

update earning_tocash_info set cutoff_earning_id = 277488 , status = 1 where id = 157 and username = 'mario_8Z8SN0F201';
update earning_tocash_info set status = 1 where id < 157 and username = 'mario_8Z8SN0F201' ;

update earning_tocash_info set cutoff_earning_id = 15289 , status = 1 where id = 20 and username = 'mario_7G9T35X445';
update earning_tocash_info set status = 1 where id < 20 and username = 'mario_7G9T35X445' ;

update earning_tocash_info set cutoff_earning_id = 243536 , status = 1 where id = 60 and username = 'mario_M4W32SCKV1';
update earning_tocash_info set status = 1 where id < 60 and username = 'mario_M4W32SCKV1' ;

update earning_tocash_info set cutoff_earning_id = 265406 , status = 1 where id = 113 and username = 'mario_C62YHF65G8';
update earning_tocash_info set status = 1 where id < 113 and username = 'mario_C62YHF65G8' ;

update earning_tocash_info set cutoff_earning_id = 302782 , status = 1 where id = 196 and username = 'mario_8RIC0519P6';
update earning_tocash_info set status = 1 where id < 196 and username = 'mario_8RIC0519P6' ;

update earning_tocash_info set cutoff_earning_id = 286002 , status = 1 where id = 164 and username = 'mario_N4J9U68654';
update earning_tocash_info set status = 1 where id < 164 and username = 'mario_N4J9U68654' ;

update earning_tocash_info set cutoff_earning_id = 255120 , status = 1 where id = 83 and username = 'mario_86O3419T36';
update earning_tocash_info set status = 1 where id < 83 and username = 'mario_86O3419T36' ;

update earning_tocash_info set cutoff_earning_id = 297574 , status = 1 where id = 173 and username = 'mario_8M2QW51W16';
update earning_tocash_info set status = 1 where id < 173 and username = 'mario_8M2QW51W16' ;

update earning_tocash_info set cutoff_earning_id = 300297 , status = 1 where id = 190 and username = 'mario_8B391W719F';
update earning_tocash_info set status = 1 where id < 190 and username = 'mario_8B391W719F' ;

update earning_tocash_info set cutoff_earning_id = 302586 , status = 1 where id = 195 and username = 'mario_8O2F053735';
update earning_tocash_info set status = 1 where id < 195 and username = 'mario_8O2F053735' ;

update earning_tocash_info set cutoff_earning_id = 302877 , status = 1 where id = 193 and username = 'mario_H4KHM21JUS';
update earning_tocash_info set status = 1 where id < 193 and username = 'mario_H4KHM21JUS' ;

update earning_tocash_info set cutoff_earning_id = 28923 , status = 1 where id = 143 and username = 'mario_G4ORI18160';
update earning_tocash_info set status = 1 where id < 143 and username = 'mario_G4ORI18160' ;

update earning_tocash_info set cutoff_earning_id = 254856 , status = 1 where id = 80 and username = 'mario_86R3E4J452';
update earning_tocash_info set status = 1 where id < 80 and username = 'mario_86R3E4J452' ;

update earning_tocash_info set cutoff_earning_id = 250275 , status = 1 where id = 136 and username = 'mario_O43KI4AI4P';
update earning_tocash_info set status = 1 where id < 136 and username = 'mario_O43KI4AI4P' ;

update earning_tocash_info set cutoff_earning_id = 255821 , status = 1 where id = 156 and username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = 1 where id < 156 and username = 'mario_K44V1ZZ7Z3' ;

update earning_tocash_info set cutoff_earning_id = 258054 , status = 1 where id = 104 and username = 'mario_PZ3QQ6ZTQ6';
update earning_tocash_info set status = 1 where id < 104 and username = 'mario_PZ3QQ6ZTQ6' ;



update earning_tocash_info set cutoff_earning_id = 301026 , status = 1 where id = 181 and username = 'mario_8IMFLL58RO';
update earning_tocash_info set status = 1 where id < 181 and username = 'mario_8IMFLL58RO' ;

update earning_tocash_info set cutoff_earning_id = 279668 , status = 1 where id = 146 and username = 'mario_8458ASFXX4';
update earning_tocash_info set status = 1 where id < 146 and username = 'mario_8458ASFXX4' ;


update earning_tocash_info set cutoff_earning_id = 300321 , status = 1 where id = 198 and username = 'mario_DPP91XE9U5';
update earning_tocash_info set status = 1 where id < 198 and username = 'mario_DPP91XE9U5' ;

update earning_tocash_info set cutoff_earning_id = 284225 , status = 1 where id = 153 and username = 'mario_U4392Q95Q2';
update earning_tocash_info set status = 1 where id < 153 and username = 'mario_U4392Q95Q2' ;

update earning_tocash_info set cutoff_earning_id = 301482 , status = 1 where id = 180 and username = 'mario_86E38LE944';
update earning_tocash_info set status = 1 where id < 180 and username = 'mario_86E38LE944' ;

update earning_tocash_info set cutoff_earning_id = 258365 , status = 1 where id = 138 and username = 'mario_L6D33601SL';
update earning_tocash_info set status = 1 where id < 138 and username = 'mario_L6D33601SL' ;

update earning_tocash_info set cutoff_earning_id = 302325 , status = 1 where id = 188 and username = 'mario_843HK9LNWQ';
update earning_tocash_info set status = 1 where id < 188 and username = 'mario_843HK9LNWQ' ;

update earning_tocash_info set cutoff_earning_id = 269696 , status = 1 where id = 162 and username = 'mario_F4KYSFI2G0';
update earning_tocash_info set status = 1 where id < 162 and username = 'mario_F4KYSFI2G0' ;

update earning_tocash_info set cutoff_earning_id = 258121 , status = 1 where id = 92 and username = 'mario_A4398BG39M';
update earning_tocash_info set status = 1 where id < 92 and username = 'mario_A4398BG39M' ;

update earning_tocash_info set cutoff_earning_id = 248835 , status = 1 where id = 185 and username = 'mario_H4MR32WHKZ';
update earning_tocash_info set status = 1 where id < 185 and username = 'mario_H4MR32WHKZ' ;

update earning_tocash_info set cutoff_earning_id = 280624 , status = 1 where id = 142 and username = 'mario_84DV3GVM6G';
update earning_tocash_info set status = 1 where id < 142 and username = 'mario_84DV3GVM6G' ;

update earning_tocash_info set cutoff_earning_id = 255606 , status = 1 where id = 82 and username = 'mario_8R39251X47';
update earning_tocash_info set status = 1 where id < 82 and username = 'mario_8R39251X47' ;

update earning_tocash_info set cutoff_earning_id = 255841 , status = 1 where id = 165 and username = 'mario_8IU1617586';
update earning_tocash_info set status = 1 where id < 165 and username = 'mario_8IU1617586' ;

update earning_tocash_info set cutoff_earning_id = 245570 , status = 1 where id = 68 and username = 'mario_8464EQ1OVX';
update earning_tocash_info set status = 1 where id < 68 and username = 'mario_8464EQ1OVX' ;

update earning_tocash_info set cutoff_earning_id = 302818 , status = 1 where id = 197 and username = 'mario_84FL1B0855';
update earning_tocash_info set status = 1 where id < 197 and username = 'mario_84FL1B0855' ;

update earning_tocash_info set cutoff_earning_id = 133772 , status = 1 where id = 40 and username = 'mario_OJ3OIW4B9W';
update earning_tocash_info set status = 1 where id < 40 and username = 'mario_OJ3OIW4B9W' ;

update earning_tocash_info set cutoff_earning_id = 302417 , status = 1 where id = 194 and username = 'mario_8H23AEH7SS';
update earning_tocash_info set status = 1 where id < 194 and username = 'mario_8H23AEH7SS' ;



update earning_tocash_info set status = -1 where id = 200;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 200, 'mario_8O77R9X842', 1, 262.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 262.50, 2) where username = 'mario_8O77R9X842';


update earning_tocash_info set status = -1 where id = 345;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 345, 'mario_8697CDK379', 1, 1426.60, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1426.60, 2) where username = 'mario_8697CDK379';
update earning_tocash_info set status = -1 where id = 365;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 365, 'mario_8697CDK379', 1, 724.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 724.90, 2) where username = 'mario_8697CDK379';



update earning_tocash_info set status = -1 where id = 367;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 367, 'mario_8B23M58985', 1, 1219.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1219.40, 2) where username = 'mario_8B23M58985';

update earning_tocash_info set status = -1 where id = 262;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 262, 'mario_MO39044QA1', 1, 805.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 805.70, 2) where username = 'mario_MO39044QA1';
update earning_tocash_info set status = -1 where id = 266;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 266, 'mario_MO39044QA1', 1, 442.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 442.10, 2) where username = 'mario_MO39044QA1';
update earning_tocash_info set status = -1 where id = 290;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 290, 'mario_MO39044QA1', 1, 738.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 738.90, 2) where username = 'mario_MO39044QA1';
update earning_tocash_info set status = -1 where id = 335;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 335, 'mario_MO39044QA1', 1, 215.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 215.80, 2) where username = 'mario_MO39044QA1';
update earning_tocash_info set status = -1 where id = 406;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 406, 'mario_MO39044QA1', 1, 1388.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1388.90, 2) where username = 'mario_MO39044QA1';
update earning_tocash_info set status = -1 where id = 427;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 427, 'mario_MO39044QA1', 1, 792.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 792.30, 2) where username = 'mario_MO39044QA1';
update earning_tocash_info set status = -1 where id = 497;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 497, 'mario_MO39044QA1', 1, 3827.59, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3827.59, 2) where username = 'mario_MO39044QA1';

update earning_tocash_info set status = -1 where id = 268;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 268, 'mario_V4390YMOQ5', 1, 907.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 907.70, 2) where username = 'mario_V4390YMOQ5';
update earning_tocash_info set status = -1 where id = 324;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 324, 'mario_V4390YMOQ5', 1, 610.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 610.10, 2) where username = 'mario_V4390YMOQ5';
update earning_tocash_info set status = -1 where id = 396;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 396, 'mario_V4390YMOQ5', 1, 184.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 184.50, 2) where username = 'mario_V4390YMOQ5';
update earning_tocash_info set status = -1 where id = 422;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 422, 'mario_V4390YMOQ5', 1, 96.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 96.80, 2) where username = 'mario_V4390YMOQ5';

update earning_tocash_info set status = -1 where id = 228;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 228, 'mario_84P91B8554', 1, 911.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 911.30, 2) where username = 'mario_84P91B8554';
update earning_tocash_info set status = -1 where id = 249;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 249, 'mario_84P91B8554', 1, 995.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 995.50, 2) where username = 'mario_84P91B8554';
update earning_tocash_info set status = -1 where id = 323;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 323, 'mario_84P91B8554', 1, 2532.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2532.30, 2) where username = 'mario_84P91B8554';
update earning_tocash_info set status = -1 where id = 395;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 395, 'mario_84P91B8554', 1, 3758.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3758.70, 2) where username = 'mario_84P91B8554';
update earning_tocash_info set status = -1 where id = 413;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 413, 'mario_84P91B8554', 1, 2778.67, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2778.67, 2) where username = 'mario_84P91B8554';
update earning_tocash_info set status = -1 where id = 482;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 482, 'mario_84P91B8554', 1, 2948.97, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2948.97, 2) where username = 'mario_84P91B8554';

update earning_tocash_info set status = -1 where id = 379;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 379, 'mario_8OX34X7658', 1, 261.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 261.30, 2) where username = 'mario_8OX34X7658';

update earning_tocash_info set status = -1 where id = 227;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 227, 'mario_I4XMF258R7', 1, 1705.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1705.80, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 237;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 237, 'mario_I4XMF258R7', 1, 514.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 514.90, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 247;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 247, 'mario_I4XMF258R7', 1, 472.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 472.00, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 252;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 252, 'mario_I4XMF258R7', 1, 679.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 679.70, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 291;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 291, 'mario_I4XMF258R7', 1, 297.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 297.80, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 348;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 348, 'mario_I4XMF258R7', 1, 386.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 386.10, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 370;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 370, 'mario_I4XMF258R7', 1, 2059.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2059.40, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 418;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 418, 'mario_I4XMF258R7', 1, 1478.66, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1478.66, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 437;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 437, 'mario_I4XMF258R7', 1, 299.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 299.80, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 478;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 478, 'mario_I4XMF258R7', 1, 519.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 519.10, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 501;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 501, 'mario_I4XMF258R7', 1, 3461.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3461.20, 2) where username = 'mario_I4XMF258R7';
update earning_tocash_info set status = -1 where id = 507;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 507, 'mario_I4XMF258R7', 1, 99.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 99.90, 2) where username = 'mario_I4XMF258R7';

update earning_tocash_info set status = -1 where id = 327;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 327, 'mario_84F9T2EL58', 1, 74.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 74.50, 2) where username = 'mario_84F9T2EL58';
update earning_tocash_info set status = -1 where id = 440;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 440, 'mario_84F9T2EL58', 1, 358.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 358.30, 2) where username = 'mario_84F9T2EL58';
update earning_tocash_info set status = -1 where id = 467;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 467, 'mario_84F9T2EL58', 1, 438.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 438.20, 2) where username = 'mario_84F9T2EL58';
update earning_tocash_info set status = -1 where id = 494;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 494, 'mario_84F9T2EL58', 1, 215.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 215.40, 2) where username = 'mario_84F9T2EL58';

update earning_tocash_info set status = -1 where id = 300;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 300, 'mario_Y6ECDQUQ85', 1, 143.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 143.10, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 303;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 303, 'mario_Y6ECDQUQ85', 1, 184.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 184.00, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 308;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 308, 'mario_Y6ECDQUQ85', 1, 109.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 109.90, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 317;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 317, 'mario_Y6ECDQUQ85', 1, 615.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 615.40, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 330;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 330, 'mario_Y6ECDQUQ85', 1, 50.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 50.50, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 338;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 338, 'mario_Y6ECDQUQ85', 1, 181.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 181.80, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 341;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 341, 'mario_Y6ECDQUQ85', 1, 467.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 467.10, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 380;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 380, 'mario_Y6ECDQUQ85', 1, 250.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 250.00, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 383;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 383, 'mario_Y6ECDQUQ85', 1, 153.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 153.20, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 389;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 389, 'mario_Y6ECDQUQ85', 1, 44.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 44.30, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 419;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 419, 'mario_Y6ECDQUQ85', 1, 12.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 12.10, 2) where username = 'mario_Y6ECDQUQ85';
update earning_tocash_info set status = -1 where id = 451;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 451, 'mario_Y6ECDQUQ85', 1, 10.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 10.00, 2) where username = 'mario_Y6ECDQUQ85';

update earning_tocash_info set status = -1 where id = 362;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 362, 'mario_86348Y28M5', 1, 3318.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3318.40, 2) where username = 'mario_86348Y28M5';

update earning_tocash_info set status = -1 where id = 261;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 261, 'mario_8DFHIA6814', 1, 211.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 211.70, 2) where username = 'mario_8DFHIA6814';

update earning_tocash_info set status = -1 where id = 374;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 374, 'mario_84RLZAR505', 1, 4553.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 4553.00, 2) where username = 'mario_84RLZAR505';

update earning_tocash_info set status = -1 where id = 214;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 214, 'mario_OHK91V5W9P', 1, 469.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 469.10, 2) where username = 'mario_OHK91V5W9P';

update earning_tocash_info set status = -1 where id = 333;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 333, 'mario_JTTK2C55DO', 1, 662.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 662.00, 2) where username = 'mario_JTTK2C55DO';
update earning_tocash_info set status = -1 where id = 412;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 412, 'mario_JTTK2C55DO', 1, 178.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 178.20, 2) where username = 'mario_JTTK2C55DO';
update earning_tocash_info set status = -1 where id = 425;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 425, 'mario_JTTK2C55DO', 1, 317.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 317.50, 2) where username = 'mario_JTTK2C55DO';

update earning_tocash_info set status = -1 where id = 220;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 220, 'mario_8IU37UKLM3', 1, 3070.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3070.20, 2) where username = 'mario_8IU37UKLM3';
update earning_tocash_info set status = -1 where id = 394;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 394, 'mario_8IU37UKLM3', 1, 6114.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 6114.30, 2) where username = 'mario_8IU37UKLM3';

update earning_tocash_info set status = -1 where id = 313;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 313, 'mario_8623455NXZ', 1, 644.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 644.20, 2) where username = 'mario_8623455NXZ';
update earning_tocash_info set status = -1 where id = 339;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 339, 'mario_8623455NXZ', 1, 818.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 818.40, 2) where username = 'mario_8623455NXZ';
update earning_tocash_info set status = -1 where id = 368;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 368, 'mario_8623455NXZ', 1, 71.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 71.70, 2) where username = 'mario_8623455NXZ';

update earning_tocash_info set status = -1 where id = 241;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 241, 'mario_Q4393GT264', 1, 1820.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1820.90, 2) where username = 'mario_Q4393GT264';
update earning_tocash_info set status = -1 where id = 316;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 316, 'mario_Q4393GT264', 1, 1249.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1249.90, 2) where username = 'mario_Q4393GT264';
update earning_tocash_info set status = -1 where id = 340;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 340, 'mario_Q4393GT264', 1, 77.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 77.00, 2) where username = 'mario_Q4393GT264';
update earning_tocash_info set status = -1 where id = 411;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 411, 'mario_Q4393GT264', 1, 2044.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2044.70, 2) where username = 'mario_Q4393GT264';
update earning_tocash_info set status = -1 where id = 414;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 414, 'mario_Q4393GT264', 1, 862.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 862.80, 2) where username = 'mario_Q4393GT264';
update earning_tocash_info set status = -1 where id = 446;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 446, 'mario_Q4393GT264', 1, 1367.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1367.80, 2) where username = 'mario_Q4393GT264';

update earning_tocash_info set status = -1 where id = 461;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 461, 'mario_G439YA4LBJ', 1, 3140.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3140.90, 2) where username = 'mario_G439YA4LBJ';
update earning_tocash_info set status = -1 where id = 463;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 463, 'mario_G439YA4LBJ', 1, 297.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 297.80, 2) where username = 'mario_G439YA4LBJ';
update earning_tocash_info set status = -1 where id = 464;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 464, 'mario_G439YA4LBJ', 1, 126.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 126.30, 2) where username = 'mario_G439YA4LBJ';
update earning_tocash_info set status = -1 where id = 470;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 470, 'mario_G439YA4LBJ', 1, 206.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 206.00, 2) where username = 'mario_G439YA4LBJ';
update earning_tocash_info set status = -1 where id = 479;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 479, 'mario_G439YA4LBJ', 1, 154.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 154.10, 2) where username = 'mario_G439YA4LBJ';

update earning_tocash_info set status = -1 where id = 222;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 222, 'mario_8G4U797912', 1, 806.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 806.90, 2) where username = 'mario_8G4U797912';
update earning_tocash_info set status = -1 where id = 250;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 250, 'mario_8G4U797912', 1, 586.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 586.80, 2) where username = 'mario_8G4U797912';
update earning_tocash_info set status = -1 where id = 307;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 307, 'mario_8G4U797912', 1, 853.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 853.30, 2) where username = 'mario_8G4U797912';
update earning_tocash_info set status = -1 where id = 382;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 382, 'mario_8G4U797912', 1, 200.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 200.40, 2) where username = 'mario_8G4U797912';
update earning_tocash_info set status = -1 where id = 484;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 484, 'mario_8G4U797912', 1, 1256.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1256.20, 2) where username = 'mario_8G4U797912';

update earning_tocash_info set status = -1 where id = 439;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 439, 'mario_E6W3M789NG', 1, 528.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 528.90, 2) where username = 'mario_E6W3M789NG';

update earning_tocash_info set status = -1 where id = 234;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 234, 'mario_8U23A24531', 1, 85.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 85.00, 2) where username = 'mario_8U23A24531';

update earning_tocash_info set status = -1 where id = 311;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 311, 'mario_P62SCH7R89', 1, 478.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 478.20, 2) where username = 'mario_P62SCH7R89';

update earning_tocash_info set status = -1 where id = 251;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 251, 'mario_J5OPKJ3C61', 1, 1836.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1836.50, 2) where username = 'mario_J5OPKJ3C61';

update earning_tocash_info set status = -1 where id = 483;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 483, 'mario_84Y9Y784V5', 1, 1684.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1684.30, 2) where username = 'mario_84Y9Y784V5';
update earning_tocash_info set status = -1 where id = 502;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 502, 'mario_84Y9Y784V5', 1, 357.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 357.10, 2) where username = 'mario_84Y9Y784V5';

update earning_tocash_info set status = -1 where id = 306;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 306, 'mario_J6AY40P9SM', 1, 26.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 26.20, 2) where username = 'mario_J6AY40P9SM';
update earning_tocash_info set status = -1 where id = 343;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 343, 'mario_J6AY40P9SM', 1, 1142.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1142.50, 2) where username = 'mario_J6AY40P9SM';
update earning_tocash_info set status = -1 where id = 366;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 366, 'mario_J6AY40P9SM', 1, 1274.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1274.50, 2) where username = 'mario_J6AY40P9SM';
update earning_tocash_info set status = -1 where id = 404;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 404, 'mario_J6AY40P9SM', 1, 92.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 92.00, 2) where username = 'mario_J6AY40P9SM';

update earning_tocash_info set status = -1 where id = 328;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 328, 'mario_843YE311JQ', 1, 837.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 837.70, 2) where username = 'mario_843YE311JQ';
update earning_tocash_info set status = -1 where id = 475;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 475, 'mario_843YE311JQ', 1, 1176.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1176.40, 2) where username = 'mario_843YE311JQ';

update earning_tocash_info set status = -1 where id = 216;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 216, 'mario_84DT17GULR', 1, 158.60, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 158.60, 2) where username = 'mario_84DT17GULR';
update earning_tocash_info set status = -1 where id = 392;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 392, 'mario_84DT17GULR', 1, 44.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 44.10, 2) where username = 'mario_84DT17GULR';
update earning_tocash_info set status = -1 where id = 458;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 458, 'mario_84DT17GULR', 1, 275.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 275.00, 2) where username = 'mario_84DT17GULR';
update earning_tocash_info set status = -1 where id = 489;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 489, 'mario_84DT17GULR', 1, 633.76, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 633.76, 2) where username = 'mario_84DT17GULR';

update earning_tocash_info set status = -1 where id = 223;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 223, 'mario_8Z8SN0F201', 1, 128.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 128.80, 2) where username = 'mario_8Z8SN0F201';
update earning_tocash_info set status = -1 where id = 289;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 289, 'mario_8Z8SN0F201', 1, 455.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 455.50, 2) where username = 'mario_8Z8SN0F201';
update earning_tocash_info set status = -1 where id = 321;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 321, 'mario_8Z8SN0F201', 1, 206.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 206.90, 2) where username = 'mario_8Z8SN0F201';
update earning_tocash_info set status = -1 where id = 342;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 342, 'mario_8Z8SN0F201', 1, 200.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 200.90, 2) where username = 'mario_8Z8SN0F201';
update earning_tocash_info set status = -1 where id = 373;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 373, 'mario_8Z8SN0F201', 1, 483.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 483.70, 2) where username = 'mario_8Z8SN0F201';
update earning_tocash_info set status = -1 where id = 430;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 430, 'mario_8Z8SN0F201', 1, 1489.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1489.90, 2) where username = 'mario_8Z8SN0F201';
update earning_tocash_info set status = -1 where id = 453;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 453, 'mario_8Z8SN0F201', 1, 56.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 56.80, 2) where username = 'mario_8Z8SN0F201';
update earning_tocash_info set status = -1 where id = 486;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 486, 'mario_8Z8SN0F201', 1, 547.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 547.20, 2) where username = 'mario_8Z8SN0F201';


update earning_tocash_info set status = -1 where id = 371;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 371, 'mario_M4W32SCKV1', 1, 887.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 887.40, 2) where username = 'mario_M4W32SCKV1';
update earning_tocash_info set status = -1 where id = 471;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 471, 'mario_M4W32SCKV1', 1, 680.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 680.70, 2) where username = 'mario_M4W32SCKV1';

update earning_tocash_info set status = -1 where id = 215;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 215, 'mario_C62YHF65G8', 1, 1434.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1434.80, 2) where username = 'mario_C62YHF65G8';

update earning_tocash_info set status = -1 where id = 337;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 337, 'mario_8RIC0519P6', 1, 4655.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 4655.40, 2) where username = 'mario_8RIC0519P6';
update earning_tocash_info set status = -1 where id = 377;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 377, 'mario_8RIC0519P6', 1, 1446.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1446.00, 2) where username = 'mario_8RIC0519P6';

update earning_tocash_info set status = -1 where id = 244;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 244, 'mario_N4J9U68654', 1, 642.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 642.90, 2) where username = 'mario_N4J9U68654';
update earning_tocash_info set status = -1 where id = 254;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 254, 'mario_N4J9U68654', 1, 149.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 149.80, 2) where username = 'mario_N4J9U68654';
update earning_tocash_info set status = -1 where id = 267;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 267, 'mario_N4J9U68654', 1, 204.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 204.00, 2) where username = 'mario_N4J9U68654';
update earning_tocash_info set status = -1 where id = 269;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 269, 'mario_N4J9U68654', 1, 589.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 589.10, 2) where username = 'mario_N4J9U68654';
update earning_tocash_info set status = -1 where id = 278;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 278, 'mario_N4J9U68654', 1, 24.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 24.00, 2) where username = 'mario_N4J9U68654';
update earning_tocash_info set status = -1 where id = 288;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 288, 'mario_N4J9U68654', 1, 107.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 107.70, 2) where username = 'mario_N4J9U68654';
update earning_tocash_info set status = -1 where id = 296;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 296, 'mario_N4J9U68654', 1, 292.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 292.20, 2) where username = 'mario_N4J9U68654';
update earning_tocash_info set status = -1 where id = 309;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 309, 'mario_N4J9U68654', 1, 102.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 102.20, 2) where username = 'mario_N4J9U68654';
update earning_tocash_info set status = -1 where id = 312;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 312, 'mario_N4J9U68654', 1, 141.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 141.10, 2) where username = 'mario_N4J9U68654';

update earning_tocash_info set status = -1 where id = 225;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 225, 'mario_86O3419T36', 1, 91.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 91.50, 2) where username = 'mario_86O3419T36';
update earning_tocash_info set status = -1 where id = 344;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 344, 'mario_86O3419T36', 1, 1223.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1223.00, 2) where username = 'mario_86O3419T36';


update earning_tocash_info set status = -1 where id = 293;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 293, 'mario_8B391W719F', 1, 1500.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1500.90, 2) where username = 'mario_8B391W719F';
update earning_tocash_info set status = -1 where id = 320;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 320, 'mario_8B391W719F', 1, 890.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 890.00, 2) where username = 'mario_8B391W719F';
update earning_tocash_info set status = -1 where id = 360;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 360, 'mario_8B391W719F', 1, 1420.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1420.80, 2) where username = 'mario_8B391W719F';
update earning_tocash_info set status = -1 where id = 452;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 452, 'mario_8B391W719F', 1, 1984.60, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1984.60, 2) where username = 'mario_8B391W719F';
update earning_tocash_info set status = -1 where id = 490;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 490, 'mario_8B391W719F', 1, 1602.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1602.20, 2) where username = 'mario_8B391W719F';

update earning_tocash_info set status = -1 where id = 349;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 349, 'mario_8O2F053735', 1, 3106.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3106.20, 2) where username = 'mario_8O2F053735';
update earning_tocash_info set status = -1 where id = 376;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 376, 'mario_8O2F053735', 1, 1269.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1269.30, 2) where username = 'mario_8O2F053735';
update earning_tocash_info set status = -1 where id = 405;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 405, 'mario_8O2F053735', 1, 111.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 111.40, 2) where username = 'mario_8O2F053735';

update earning_tocash_info set status = -1 where id = 204;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 204, 'mario_H4KHM21JUS', 1, 507.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 507.90, 2) where username = 'mario_H4KHM21JUS';
update earning_tocash_info set status = -1 where id = 224;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 224, 'mario_H4KHM21JUS', 1, 470.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 470.00, 2) where username = 'mario_H4KHM21JUS';
update earning_tocash_info set status = -1 where id = 230;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 230, 'mario_H4KHM21JUS', 1, 160.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 160.70, 2) where username = 'mario_H4KHM21JUS';
update earning_tocash_info set status = -1 where id = 285;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 285, 'mario_H4KHM21JUS', 1, 316.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 316.30, 2) where username = 'mario_H4KHM21JUS';
update earning_tocash_info set status = -1 where id = 408;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 408, 'mario_H4KHM21JUS', 1, 879.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 879.50, 2) where username = 'mario_H4KHM21JUS';
update earning_tocash_info set status = -1 where id = 431;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 431, 'mario_H4KHM21JUS', 1, 1235.99, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1235.99, 2) where username = 'mario_H4KHM21JUS';
update earning_tocash_info set status = -1 where id = 444;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 444, 'mario_H4KHM21JUS', 1, 751.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 751.80, 2) where username = 'mario_H4KHM21JUS';
update earning_tocash_info set status = -1 where id = 492;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 492, 'mario_H4KHM21JUS', 1, 574.08, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 574.08, 2) where username = 'mario_H4KHM21JUS';

update earning_tocash_info set status = -1 where id = 334;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 334, 'mario_G4ORI18160', 1, 3947.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3947.30, 2) where username = 'mario_G4ORI18160';
update earning_tocash_info set status = -1 where id = 436;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 436, 'mario_G4ORI18160', 1, 398.49, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 398.49, 2) where username = 'mario_G4ORI18160';

update earning_tocash_info set status = -1 where id = 301;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 301, 'mario_86R3E4J452', 1, 225.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 225.00, 2) where username = 'mario_86R3E4J452';
update earning_tocash_info set status = -1 where id = 315;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 315, 'mario_86R3E4J452', 1, 3151.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3151.00, 2) where username = 'mario_86R3E4J452';

update earning_tocash_info set status = -1 where id = 231;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 231, 'mario_O43KI4AI4P', 1, 546.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 546.90, 2) where username = 'mario_O43KI4AI4P';
update earning_tocash_info set status = -1 where id = 242;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 242, 'mario_O43KI4AI4P', 1, 247.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 247.50, 2) where username = 'mario_O43KI4AI4P';
update earning_tocash_info set status = -1 where id = 270;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 270, 'mario_O43KI4AI4P', 1, 328.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 328.90, 2) where username = 'mario_O43KI4AI4P';
update earning_tocash_info set status = -1 where id = 299;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 299, 'mario_O43KI4AI4P', 1, 583.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 583.10, 2) where username = 'mario_O43KI4AI4P';
update earning_tocash_info set status = -1 where id = 423;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 423, 'mario_O43KI4AI4P', 1, 239.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 239.90, 2) where username = 'mario_O43KI4AI4P';
update earning_tocash_info set status = -1 where id = 462;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 462, 'mario_O43KI4AI4P', 1, 891.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 891.10, 2) where username = 'mario_O43KI4AI4P';

update earning_tocash_info set status = -1 where id = 232;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 232, 'mario_K44V1ZZ7Z3', 1, 690.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 690.00, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 272;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 272, 'mario_K44V1ZZ7Z3', 1, 488.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 488.80, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 274;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 274, 'mario_K44V1ZZ7Z3', 1, 113.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 113.00, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 381;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 381, 'mario_K44V1ZZ7Z3', 1, 488.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 488.50, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 400;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 400, 'mario_K44V1ZZ7Z3', 1, 1256.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1256.40, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 402;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 402, 'mario_K44V1ZZ7Z3', 1, 529.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 529.50, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 410;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 410, 'mario_K44V1ZZ7Z3', 1, 371.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 371.00, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 443;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 443, 'mario_K44V1ZZ7Z3', 1, 1102.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1102.40, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 448;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 448, 'mario_K44V1ZZ7Z3', 1, 347.60, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 347.60, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 459;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 459, 'mario_K44V1ZZ7Z3', 1, 1735.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1735.50, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 485;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 485, 'mario_K44V1ZZ7Z3', 1, 628.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 628.10, 2) where username = 'mario_K44V1ZZ7Z3';
update earning_tocash_info set status = -1 where id = 499;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 499, 'mario_K44V1ZZ7Z3', 1, 865.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 865.40, 2) where username = 'mario_K44V1ZZ7Z3';

update earning_tocash_info set status = -1 where id = 218;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 218, 'mario_PZ3QQ6ZTQ6', 1, 55.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 55.40, 2) where username = 'mario_PZ3QQ6ZTQ6';
update earning_tocash_info set status = -1 where id = 243;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 243, 'mario_PZ3QQ6ZTQ6', 1, 49.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 49.00, 2) where username = 'mario_PZ3QQ6ZTQ6';
update earning_tocash_info set status = -1 where id = 255;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 255, 'mario_PZ3QQ6ZTQ6', 1, 83.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 83.00, 2) where username = 'mario_PZ3QQ6ZTQ6';
update earning_tocash_info set status = -1 where id = 310;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 310, 'mario_PZ3QQ6ZTQ6', 1, 32.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 32.10, 2) where username = 'mario_PZ3QQ6ZTQ6';
update earning_tocash_info set status = -1 where id = 397;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 397, 'mario_PZ3QQ6ZTQ6', 1, 26.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 26.00, 2) where username = 'mario_PZ3QQ6ZTQ6';
update earning_tocash_info set status = -1 where id = 415;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 415, 'mario_PZ3QQ6ZTQ6', 1, 92.88, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 92.88, 2) where username = 'mario_PZ3QQ6ZTQ6';
update earning_tocash_info set status = -1 where id = 454;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 454, 'mario_PZ3QQ6ZTQ6', 1, 67.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 67.10, 2) where username = 'mario_PZ3QQ6ZTQ6';
update earning_tocash_info set status = -1 where id = 487;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 487, 'mario_PZ3QQ6ZTQ6', 1, 10.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 10.50, 2) where username = 'mario_PZ3QQ6ZTQ6';
update earning_tocash_info set status = -1 where id = 505;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 505, 'mario_PZ3QQ6ZTQ6', 1, 16.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 16.00, 2) where username = 'mario_PZ3QQ6ZTQ6';

update earning_tocash_info set status = -1 where id = 201;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 201, 'mario_8IMFLL58RO', 1, 867.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 867.10, 2) where username = 'mario_8IMFLL58RO';
update earning_tocash_info set status = -1 where id = 347;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 347, 'mario_8IMFLL58RO', 1, 2592.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2592.20, 2) where username = 'mario_8IMFLL58RO';
update earning_tocash_info set status = -1 where id = 387;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 387, 'mario_8IMFLL58RO', 1, 3078.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 3078.40, 2) where username = 'mario_8IMFLL58RO';
update earning_tocash_info set status = -1 where id = 403;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 403, 'mario_8IMFLL58RO', 1, 1810.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1810.00, 2) where username = 'mario_8IMFLL58RO';
update earning_tocash_info set status = -1 where id = 445;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 445, 'mario_8IMFLL58RO', 1, 1647.96, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1647.96, 2) where username = 'mario_8IMFLL58RO';
update earning_tocash_info set status = -1 where id = 480;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 480, 'mario_8IMFLL58RO', 1, 2395.61, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2395.61, 2) where username = 'mario_8IMFLL58RO';

update earning_tocash_info set status = -1 where id = 295;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 295, 'mario_8458ASFXX4', 1, 1315.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1315.80, 2) where username = 'mario_8458ASFXX4';
update earning_tocash_info set status = -1 where id = 424;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 424, 'mario_8458ASFXX4', 1, 1343.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1343.00, 2) where username = 'mario_8458ASFXX4';
update earning_tocash_info set status = -1 where id = 456;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 456, 'mario_8458ASFXX4', 1, 1201.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1201.30, 2) where username = 'mario_8458ASFXX4';
update earning_tocash_info set status = -1 where id = 477;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 477, 'mario_8458ASFXX4', 1, 1795.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1795.50, 2) where username = 'mario_8458ASFXX4';

update earning_tocash_info set status = -1 where id = 503;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 503, 'mario_DPP91XE9U5', 1, 1017.60, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1017.60, 2) where username = 'mario_DPP91XE9U5';

update earning_tocash_info set status = -1 where id = 375;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 375, 'mario_K4M92166NM', 1, 757.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 757.20, 2) where username = 'mario_K4M92166NM';

update earning_tocash_info set status = -1 where id = 233;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 233, 'mario_U4392Q95Q2', 1, 62.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 62.00, 2) where username = 'mario_U4392Q95Q2';
update earning_tocash_info set status = -1 where id = 248;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 248, 'mario_U4392Q95Q2', 1, 65.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 65.10, 2) where username = 'mario_U4392Q95Q2';
update earning_tocash_info set status = -1 where id = 271;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 271, 'mario_U4392Q95Q2', 1, 19.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 19.10, 2) where username = 'mario_U4392Q95Q2';
update earning_tocash_info set status = -1 where id = 326;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 326, 'mario_U4392Q95Q2', 1, 15.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 15.50, 2) where username = 'mario_U4392Q95Q2';
update earning_tocash_info set status = -1 where id = 432;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 432, 'mario_U4392Q95Q2', 1, 77.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 77.70, 2) where username = 'mario_U4392Q95Q2';
update earning_tocash_info set status = -1 where id = 433;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 433, 'mario_U4392Q95Q2', 1, 33.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 33.20, 2) where username = 'mario_U4392Q95Q2';
update earning_tocash_info set status = -1 where id = 508;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 508, 'mario_U4392Q95Q2', 1, 32.76, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 32.76, 2) where username = 'mario_U4392Q95Q2';

update earning_tocash_info set status = -1 where id = 336;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 336, 'mario_86E38LE944', 1, 476.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 476.50, 2) where username = 'mario_86E38LE944';
update earning_tocash_info set status = -1 where id = 385;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 385, 'mario_86E38LE944', 1, 1308.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1308.00, 2) where username = 'mario_86E38LE944';

update earning_tocash_info set status = -1 where id = 401;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 401, 'mario_L6D33601SL', 1, 5095.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 5095.30, 2) where username = 'mario_L6D33601SL';

update earning_tocash_info set status = -1 where id = 202;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 202, 'mario_843HK9LNWQ', 1, 1528.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1528.50, 2) where username = 'mario_843HK9LNWQ';
update earning_tocash_info set status = -1 where id = 281;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 281, 'mario_843HK9LNWQ', 1, 2695.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2695.50, 2) where username = 'mario_843HK9LNWQ';
update earning_tocash_info set status = -1 where id = 363;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 363, 'mario_843HK9LNWQ', 1, 2971.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2971.90, 2) where username = 'mario_843HK9LNWQ';
update earning_tocash_info set status = -1 where id = 428;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 428, 'mario_843HK9LNWQ', 1, 2411.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2411.50, 2) where username = 'mario_843HK9LNWQ';

update earning_tocash_info set status = -1 where id = 257;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 257, 'mario_F4KYSFI2G0', 1, 111.30, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 111.30, 2) where username = 'mario_F4KYSFI2G0';

update earning_tocash_info set status = -1 where id = 239;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 239, 'mario_A4398BG39M', 1, 116.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 116.50, 2) where username = 'mario_A4398BG39M';
update earning_tocash_info set status = -1 where id = 297;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 297, 'mario_A4398BG39M', 1, 129.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 129.10, 2) where username = 'mario_A4398BG39M';
update earning_tocash_info set status = -1 where id = 429;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 429, 'mario_A4398BG39M', 1, 82.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 82.20, 2) where username = 'mario_A4398BG39M';
update earning_tocash_info set status = -1 where id = 457;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 457, 'mario_A4398BG39M', 1, 67.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 67.50, 2) where username = 'mario_A4398BG39M';
update earning_tocash_info set status = -1 where id = 466;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 466, 'mario_A4398BG39M', 1, 193.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 193.80, 2) where username = 'mario_A4398BG39M';

update earning_tocash_info set status = -1 where id = 391;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 391, 'mario_H4MR32WHKZ', 1, 2139.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2139.00, 2) where username = 'mario_H4MR32WHKZ';
update earning_tocash_info set status = -1 where id = 455;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 455, 'mario_H4MR32WHKZ', 1, 795.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 795.20, 2) where username = 'mario_H4MR32WHKZ';
update earning_tocash_info set status = -1 where id = 500;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 500, 'mario_H4MR32WHKZ', 1, 860.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 860.00, 2) where username = 'mario_H4MR32WHKZ';

update earning_tocash_info set status = -1 where id = 240;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 240, 'mario_84DV3GVM6G', 1, 956.40, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 956.40, 2) where username = 'mario_84DV3GVM6G';
update earning_tocash_info set status = -1 where id = 264;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 264, 'mario_84DV3GVM6G', 1, 208.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 208.00, 2) where username = 'mario_84DV3GVM6G';
update earning_tocash_info set status = -1 where id = 329;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 329, 'mario_84DV3GVM6G', 1, 857.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 857.50, 2) where username = 'mario_84DV3GVM6G';
update earning_tocash_info set status = -1 where id = 407;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 407, 'mario_84DV3GVM6G', 1, 1580.60, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1580.60, 2) where username = 'mario_84DV3GVM6G';

update earning_tocash_info set status = -1 where id = 426;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 426, 'mario_8R39251X47', 1, 83.80, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 83.80, 2) where username = 'mario_8R39251X47';

update earning_tocash_info set status = -1 where id = 263;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 263, 'mario_8IU1617586', 1, 1489.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1489.90, 2) where username = 'mario_8IU1617586';
update earning_tocash_info set status = -1 where id = 287;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 287, 'mario_8IU1617586', 1, 1370.90, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1370.90, 2) where username = 'mario_8IU1617586';
update earning_tocash_info set status = -1 where id = 472;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 472, 'mario_8IU1617586', 1, 5669.02, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 5669.02, 2) where username = 'mario_8IU1617586';

update earning_tocash_info set status = -1 where id = 495;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 495, 'mario_8464EQ1OVX', 1, 12.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 12.70, 2) where username = 'mario_8464EQ1OVX';

update earning_tocash_info set status = -1 where id = 238;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 238, 'mario_84FL1B0855', 1, 293.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 293.70, 2) where username = 'mario_84FL1B0855';
update earning_tocash_info set status = -1 where id = 322;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 322, 'mario_84FL1B0855', 1, 285.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 285.50, 2) where username = 'mario_84FL1B0855';
update earning_tocash_info set status = -1 where id = 332;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 332, 'mario_84FL1B0855', 1, 102.60, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 102.60, 2) where username = 'mario_84FL1B0855';
update earning_tocash_info set status = -1 where id = 361;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 361, 'mario_84FL1B0855', 1, 695.70, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 695.70, 2) where username = 'mario_84FL1B0855';
update earning_tocash_info set status = -1 where id = 409;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 409, 'mario_84FL1B0855', 1, 40.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 40.20, 2) where username = 'mario_84FL1B0855';
update earning_tocash_info set status = -1 where id = 435;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 435, 'mario_84FL1B0855', 1, 54.00, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 54.00, 2) where username = 'mario_84FL1B0855';
update earning_tocash_info set status = -1 where id = 468;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 468, 'mario_84FL1B0855', 1, 1444.50, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1444.50, 2) where username = 'mario_84FL1B0855';
update earning_tocash_info set status = -1 where id = 476;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 476, 'mario_84FL1B0855', 1, 32.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 32.10, 2) where username = 'mario_84FL1B0855';

update earning_tocash_info set status = -1 where id = 449;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 449, 'mario_OJ3OIW4B9W', 1, 1564.60, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 1564.60, 2) where username = 'mario_OJ3OIW4B9W';

update earning_tocash_info set status = -1 where id = 314;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 314, 'mario_8H23AEH7SS', 1, 693.10, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 693.10, 2) where username = 'mario_8H23AEH7SS';
update earning_tocash_info set status = -1 where id = 384;
insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, 384, 'mario_8H23AEH7SS', 1, 2297.20, 'system set pay fail', 'system', now());
update app_user_total_info set earning_balance = round(earning_balance + 2297.20, 2) where username = 'mario_8H23AEH7SS';





