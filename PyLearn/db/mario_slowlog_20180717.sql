# Time: 2018-07-17T06:20:42.658036Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2833949
# Query_time: 21.936855  Lock_time: 0.001438 Rows_sent: 0  Rows_examined: 16586994
use mario_log;
SET timestamp=1531808442;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T06:32:04.937918Z
# User@Host: root[root] @  [172.16.16.16]  Id: 2833244
# Query_time: 20.921948  Lock_time: 0.000000 Rows_sent: 0  Rows_examined: 0
use assacs;
SET timestamp=1531809124;
update common_task_workflow_420100 set task_id = 154023
		 
			,track_km_length = 0.39
		 
		 
			,trackcover_rate = 1.0
		 
		 
			,audit_trackkm_length = 0.39
		 
		 
			,audit_trackcover_rate = 1.0
		 
		where id = 76166;
# Time: 2018-07-17T06:32:15.604135Z
# User@Host: root[root] @  [172.16.16.17]  Id: 2834391
# Query_time: 10.319145  Lock_time: 0.000000 Rows_sent: 4853997  Rows_examined: 4853997
SET timestamp=1531809135;
SELECT /*!40001 SQL_NO_CACHE */ * FROM `app_user_track`;
# Time: 2018-07-17T06:32:37.523860Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2834393
# Query_time: 51.462156  Lock_time: 0.001895 Rows_sent: 0  Rows_examined: 7385323
SET timestamp=1531809157;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T06:41:31.857919Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2834753
# Query_time: 23.814541  Lock_time: 0.000000 Rows_sent: 0  Rows_examined: 0
use mario_log;
SET timestamp=1531809691;
SELECT * FROM `task_pass_cache` LIMIT 0, 1000;
# Time: 2018-07-17T06:41:49.257841Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2834744
# Query_time: 49.761537  Lock_time: 0.000000 Rows_sent: 0  Rows_examined: 0
SET timestamp=1531809709;
SELECT count(1) from task_pass_cache;
# Time: 2018-07-17T06:41:52.984524Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2834720
# Query_time: 94.431922  Lock_time: 0.000000 Rows_sent: 0  Rows_examined: 0
SET timestamp=1531809712;
DELETE from  task_pass_cache;
# Time: 2018-07-17T06:45:44.011336Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2834864
# Query_time: 110.944527  Lock_time: 0.000000 Rows_sent: 0  Rows_examined: 0
SET timestamp=1531809944;
SELECT * FROM `task_pass_cache` LIMIT 0, 1000;
# Time: 2018-07-17T06:50:29.403194Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2834783
# Query_time: 499.108702  Lock_time: 0.000000 Rows_sent: 0  Rows_examined: 0
SET timestamp=1531810229;
DROP TABLE `task_pass_cache`;
# Time: 2018-07-17T06:50:39.391153Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2834478
# Query_time: 1007.626462  Lock_time: 0.002230 Rows_sent: 0  Rows_examined: 9990220
use assacs;
SET timestamp=1531810239;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T06:53:22.383279Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2835196
# Query_time: 21.673935  Lock_time: 0.001895 Rows_sent: 0  Rows_examined: 16663349
use mario_log;
SET timestamp=1531810402;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T07:06:10.170261Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2835556
# Query_time: 227.819322  Lock_time: 0.001758 Rows_sent: 0  Rows_examined: 7886250
use assacs;
SET timestamp=1531811170;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:10:25.802161Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2835699
# Query_time: 17.357815  Lock_time: 0.001793 Rows_sent: 20  Rows_examined: 7776668
SET timestamp=1531811425;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:11:48.980574Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2835699
# Query_time: 17.092702  Lock_time: 0.001626 Rows_sent: 20  Rows_examined: 7776689
SET timestamp=1531811508;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,

	shwcrws,
	
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
		
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:12:13.063044Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2835699
# Query_time: 17.113925  Lock_time: 0.001852 Rows_sent: 20  Rows_examined: 7776670
SET timestamp=1531811533;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,

	shwcrws,
	
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
		
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:12:49.259046Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2835699
# Query_time: 17.170015  Lock_time: 0.001668 Rows_sent: 20  Rows_examined: 7852709
SET timestamp=1531811569;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,

	shwcrws,
	
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
		
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 100
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:15:06.092253Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2835699
# Query_time: 110.493640  Lock_time: 0.001735 Rows_sent: 0  Rows_examined: 7562836
SET timestamp=1531811706;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,

	shwcrws,
	
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
		
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:15:32.904518Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2836029
# Query_time: 17.291423  Lock_time: 0.001722 Rows_sent: 20  Rows_examined: 7857880
SET timestamp=1531811732;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,

	shwcrws,
	
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
		
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 5000
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:16:12.968228Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2836029
# Query_time: 17.496397  Lock_time: 0.001707 Rows_sent: 20  Rows_examined: 7902880
SET timestamp=1531811772;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,

	shwcrws,
	
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
		
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 50000
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:16:46.800992Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2836029
# Query_time: 18.278174  Lock_time: 0.001674 Rows_sent: 20  Rows_examined: 7971933
SET timestamp=1531811806;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,

	shwcrws,
	
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
		
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 100000
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:19:21.063598Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2836029
# Query_time: 18.372584  Lock_time: 0.001791 Rows_sent: 20  Rows_examined: 7971939
SET timestamp=1531811961;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,

	shwcrws,
	
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
		
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 120000
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T07:19:43.533078Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2836029
# Query_time: 17.345812  Lock_time: 0.001732 Rows_sent: 20  Rows_examined: 7971939
SET timestamp=1531811983;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,

	shwcrws,
	
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
		
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 120000
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T09:23:05.167165Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2840832
# Query_time: 35.457507  Lock_time: 0.000093 Rows_sent: 1000  Rows_examined: 1000
use mario_log;
SET timestamp=1531819385;
SELECT * FROM `log_collect_info` LIMIT 0, 1000;
# Time: 2018-07-17T09:44:32.667360Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2841432
# Query_time: 355.419642  Lock_time: 0.001778 Rows_sent: 0  Rows_examined: 8322249
use assacs;
SET timestamp=1531820672;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T09:45:24.519101Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2841716
# Query_time: 17.528100  Lock_time: 0.001928 Rows_sent: 20  Rows_examined: 8067242
SET timestamp=1531820724;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 10000000
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T10:00:36.967557Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2842119
# Query_time: 27.813396  Lock_time: 4.212675 Rows_sent: 0  Rows_examined: 16961755
use mario_log;
SET timestamp=1531821636;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T10:10:22.958606Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2842119
# Query_time: 22.725688  Lock_time: 0.001531 Rows_sent: 0  Rows_examined: 16986759
SET timestamp=1531822222;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T10:20:23.280034Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2842119
# Query_time: 22.982246  Lock_time: 0.005913 Rows_sent: 0  Rows_examined: 17009226
SET timestamp=1531822823;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T10:30:23.053266Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2842119
# Query_time: 22.777029  Lock_time: 0.001433 Rows_sent: 0  Rows_examined: 17015087
SET timestamp=1531823423;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T10:40:23.232628Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2842119
# Query_time: 22.925685  Lock_time: 0.001297 Rows_sent: 0  Rows_examined: 17016793
SET timestamp=1531824023;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T10:50:31.816657Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2843931
# Query_time: 22.334465  Lock_time: 0.001382 Rows_sent: 0  Rows_examined: 17019319
SET timestamp=1531824631;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T11:00:22.215999Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2843931
# Query_time: 21.933947  Lock_time: 0.001354 Rows_sent: 0  Rows_examined: 17019869
SET timestamp=1531825222;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T11:03:45.306332Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2844650
# Query_time: 41.517939  Lock_time: 0.000271 Rows_sent: 1425  Rows_examined: 121557
use assacs;
SET timestamp=1531825425;
SELECT a.* from common_task_420100 a LEFT JOIN mario_log.task_pass_cache b  on a.id=b.task_id;
# Time: 2018-07-17T11:05:26.550564Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2844733
# Query_time: 14.103108  Lock_time: 0.000211 Rows_sent: 666  Rows_examined: 243957
use mario_log;
SET timestamp=1531825526;
SELECT a.* from log_aoi a LEFT JOIN mario_log.task_pass_cache b  on a.task_id=b.task_id limit 10000;
# Time: 2018-07-17T11:06:20.347340Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2844749
# Query_time: 45.476419  Lock_time: 0.000206 Rows_sent: 2021  Rows_examined: 963646
SET timestamp=1531825580;
SELECT a.* from log_aoi a LEFT JOIN mario_log.task_pass_cache b  on a.task_id=b.task_id limit 10000;
# Time: 2018-07-17T11:10:22.809677Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2843931
# Query_time: 22.544183  Lock_time: 0.003198 Rows_sent: 0  Rows_examined: 17029235
SET timestamp=1531825822;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T11:11:00.071564Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2844922
# Query_time: 41.824245  Lock_time: 0.001813 Rows_sent: 0  Rows_examined: 7490507
use assacs;
SET timestamp=1531825860;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN mario_log.task_pass_cache b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:11:23.982387Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2844957
# Query_time: 17.505433  Lock_time: 0.001723 Rows_sent: 20  Rows_examined: 8091080
SET timestamp=1531825883;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 10000000
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:13:25.698316Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2844957
# Query_time: 18.563025  Lock_time: 0.001652 Rows_sent: 0  Rows_examined: 7414169
SET timestamp=1531826005;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:14:20.006819Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845063
# Query_time: 17.248663  Lock_time: 0.002029 Rows_sent: 0  Rows_examined: 7411322
SET timestamp=1531826060;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:15:21.270727Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845089
# Query_time: 50.124992  Lock_time: 0.001886 Rows_sent: 0  Rows_examined: 7502577
SET timestamp=1531826121;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:15:49.017109Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845126
# Query_time: 17.526973  Lock_time: 0.001826 Rows_sent: 20  Rows_examined: 8090420
SET timestamp=1531826149;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1 limit 10000000
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:20:31.758589Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2843931
# Query_time: 22.609542  Lock_time: 0.001531 Rows_sent: 0  Rows_examined: 17032883
use mario_log;
SET timestamp=1531826431;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T11:25:10.513225Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845126
# Query_time: 35.920112  Lock_time: 0.001697 Rows_sent: 0  Rows_examined: 7462767
use assacs;
SET timestamp=1531826710;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:26:54.997398Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845493
# Query_time: 84.189465  Lock_time: 0.002128 Rows_sent: 0  Rows_examined: 7607801
SET timestamp=1531826814;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			)
		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:28:30.851183Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845557
# Query_time: 65.703491  Lock_time: 0.001835 Rows_sent: 1  Rows_examined: 7566683
SET timestamp=1531826910;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			) and work_user='mario_127TOP0P6W'

		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:28:53.830797Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845557
# Query_time: 15.971366  Lock_time: 0.001769 Rows_sent: 0  Rows_examined: 7191386
SET timestamp=1531826933;
EXPLAIN SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			) and work_user='mario_127TOP0P6W'

		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:30:00.991280Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845621
# Query_time: 64.944943  Lock_time: 0.002818 Rows_sent: 1  Rows_examined: 7566683
SET timestamp=1531827000;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			) and work_user='mario_127TOP0P6W'

		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:30:31.774041Z
# User@Host: mario_yy[mario_yy] @  [193.112.92.119]  Id: 2843931
# Query_time: 22.766879  Lock_time: 0.001568 Rows_sent: 0  Rows_examined: 17043345
use mario_log;
SET timestamp=1531827031;
INSERT INTO task_pass_cache  (task_id, audit_result,city_code) 
		    select *,'420100' from 
		    (
		     
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		    union
		     
      select task_id,-1  as audit_result from 
		assacs.common_task_workflow_420100 where task_id not in
		
		(select task_id from(
		  
		select task_id,1 as audit_result from (
		-- 楼栋和aoi两项都通过
		select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null  and audit_result=1  
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		UNION ALL
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1 
		AND (task_type != 3 OR (task_type=3 AND record_type=1))
		) temp 
		GROUP BY task_id,task_type
		)temp where temp.num=2
		
		-- 针对AOI一项通过一项报错审核通过（或一项无效采集）
		union
		
		SELECT a.task_id from
		
		(select task_id from assacs.common_task_data_420100 where photo_url is null   and audit_result=1  and task_type=2  
		UNION ALL
		select task_id from assacs.common_task_data_history_420100 where photo_url is null   and audit_result=1  and task_type=2 
		) a
		
		INNER JOIN
		
		(
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null  and  
		task_type=2  and (audit_result=-2    or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=2  and (audit_result=-2     or  (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) ) 
		
		) b on a.task_id=b.task_id

	    UNION
	    -- aoi两项无效采集
	    select DISTINCT task_id from(SELECT count(task_id) as num,task_id,task_type from 
		(
		select task_id,task_type,audit_result from assacs.common_task_data_420100 where photo_url is null   and audit_result=-1  and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		UNION 
		select task_id,task_type,audit_result from assacs.common_task_data_history_420100 where photo_url is null    and audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0 and task_type=2
		) temp  
		GROUP BY task_id,task_type
		)temp where temp.num=2

		
		
		union
		-- 针对楼栋不存在审核通过
		SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=1    and task_type_item =3 and cannot_work_cause =3 and audit_result=1 
		
    
		UNION
	    -- 内部路轨迹通过或者无效采集
	    SELECT task_id from assacs.common_task_data_420100 where photo_url is null   and  
		task_type=3  AND record_type=1  and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )
		UNION
		SELECT task_id from assacs.common_task_data_history_420100 where photo_url is null   and  
		task_type=3  AND record_type=1   and task_type_item =1 and (audit_result=1  or   (audit_result=-1 and LOCATE('cause_5',audit_unpass_cause)>0) )

    
    
		) task_pass
		 where
		task_id in (select task_id  from assacs.common_task_workflow_420100 where audit_completed_time is not null  )
     
		)task_pass)
		and   audit_completed_time is not null and id in(SELECT max(id) from assacs.common_task_workflow_420100 GROUP BY task_id)
		and   CONCAT(can_work,ifnull(cannot_work_cause,''))!='-12' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-13' and CONCAT(can_work,ifnull(cannot_work_cause,''))!='-14'
		and can_work=1
     
		    ) task_status;
# Time: 2018-07-17T11:31:48.613194Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845621
# Query_time: 66.812155  Lock_time: 0.002203 Rows_sent: 22  Rows_examined: 7566736
use assacs;
SET timestamp=1531827108;
EXPLAIN SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			) and work_user='mario_127TOP0P6W'

		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:36:21.721029Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845621
# Query_time: 16.206109  Lock_time: 0.001873 Rows_sent: 1  Rows_examined: 7327615
SET timestamp=1531827381;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			) and work_user='mario_127TOP0P6W'

		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
# Time: 2018-07-17T11:36:46.423931Z
# User@Host: mario_yy[mario_yy] @  [58.48.194.238]  Id: 2845621
# Query_time: 17.995763  Lock_time: 0.001870 Rows_sent: 20  Rows_examined: 7973676
SET timestamp=1531827406;
SELECT
	*, ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy,
	ifnull(
		CONVERT (sy_dh / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy_dh,
	ifnull(lqrws, 0) + ifnull(lqrws_m, 0) AS lqrw,
	ifnull(lqrws_aoi, 0) + ifnull(lqrws_aoi_m, 0) AS lqrw_aoi,
	ifnull(lqrws_nbl, 0) + ifnull(lqrws_nbl_m, 0) AS lqrw_nbl,
	ifnull(
		CONVERT (
			wcrws_all / zysc,
			DECIMAL (10, 2)
		),
		0
	) dwsjwcrws,
	shtgrws,
	shwcrws,
	(
		CASE
		WHEN shwcrws = 0 THEN
			'-'
		ELSE
			concat(
				ifnull(
					CONVERT (
						(shtgrws / shwcrws) * 100,
						DECIMAL (10, 2)
					),
					0
				),
				'%'
			)
		END
	) shtgl,
	ifnull(
		CONVERT (sy / zysc, DECIMAL(10, 2)),
		0
	) AS dwsjsy
FROM
	(
		SELECT
			sum(
				CASE
				WHEN m.type = 1 THEN
					1
				ELSE
					0
				END
			) AS lqrws,
			sum(
				CASE
				WHEN m.type = 1
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 1
			) AS lqrws_m,
			sum(
				CASE
				WHEN m.type = 2 THEN
					1
				ELSE
					0
				END
			) AS lqrws_aoi,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 2
			) AS lqrws_aoi_m,
			sum(
				CASE
				WHEN m.type = 2
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_aoi,
			sum(
				CASE
				WHEN m.type = 3 THEN
					1
				ELSE
					0
				END
			) AS lqrws_nbl,
			(
				SELECT
					count(1)
				FROM
					common_task_420100 g
				LEFT JOIN aoi_info h ON g.aoi_guid = h.guid
				WHERE
					h.work_user = a.work_user
				AND g.type = 3
			) AS lqrws_nbl_m,
			sum(
				CASE
				WHEN m.type = 3
				AND work_submit_time IS NOT NULL THEN
					1
				ELSE
					0
				END
			) AS wcrws_nbl,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_cj_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND work_submit_time IS NOT NULL THEN
						task_item_item.pmt_mc_tj
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item.ld_tj
					ELSE
						0
					END
				),
				0
			) AS ld_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND work_submit_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_tj
					ELSE
						0
					END
				),
				0
			) AS ld_dym_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.nbl_tj
					ELSE
						0
					END
				),
				0
			) AS nbl_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND work_submit_time IS NOT NULL THEN
						task_item_item.tzd_tj
					ELSE
						0
					END
				),
				0
			) AS tzd_tj,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_sh
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_sh
					ELSE
						0
					END
				),
				0
			) AS ld_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_sh
					ELSE
						0
					END
				),
				0
			) AS ld_dym_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_sh
					ELSE
						0
					END
				),
				0
			) AS nbl_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_sh
					ELSE
						0
					END
				),
				0
			) AS tzd_sh,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_cj_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_cj_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 2
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.pmt_mc_shtg
					ELSE
						0
					END
				),
				0
			) AS pmt_mc_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.ld_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 1
					AND audit_completed_time IS NOT NULL THEN
						task_item_item_dym.ld_dym_shtg
					ELSE
						0
					END
				),
				0
			) AS ld_dym_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.nbl_shtg
					ELSE
						0
					END
				),
				0
			) AS nbl_shtg,
			ifnull(
				sum(
					CASE
					WHEN m.type = 3
					AND audit_completed_time IS NOT NULL THEN
						task_item_item.tzd_shtg
					ELSE
						0
					END
				),
				0
			) AS tzd_shtg,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND work_submit_time IS NOT NULL THEN
							a.track_km_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_tj_lc,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN m.type = 3
						AND audit_completed_time IS NOT NULL THEN
							a.audit_trackkm_length
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS nbl_shtg_lc,
			ifnull(
				CONVERT (
					(
						CASE
						WHEN 1 = 1 THEN
							period.period
						ELSE
							0
						END
					) / 3600,
					DECIMAL (10, 2)
				),
				0
			) AS zysc,
			CONVERT (
				ifnull(
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					0
				),
				DECIMAL (10, 2)
			) AS wcrwyjsy,
			ifnull(
				sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END),
				0
			) AS wcrws_all,
			ifnull(
				sum(
					CASE
					WHEN b.audit_result = 1
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shtgrws,
			ifnull(
				sum(
					CASE
					WHEN a.audit_completed_time IS NOT NULL
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-12'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-13'
					AND CONCAT(
						can_work,
						ifnull(cannot_work_cause, '')
					) != '-14' THEN
						1
					ELSE
						0
					END
				),
				0
			) AS shwcrws,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS shtgsjsy,
			sum(CASE WHEN 1 = 1 THEN 1 ELSE 0 END) AS zycs,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy_dh,
			ifnull(
				CONVERT (
					sum(
						CASE
						WHEN 1 = 1 THEN
							earning
						ELSE
							0
						END
					),
					DECIMAL (10, 2)
				),
				0
			) AS sy,
			c.username,
			c.alipay_realname
		FROM
			(
				SELECT
					id,
					task_id,
					work_user,
					work_submit_time,
					work_get_time,
					earning,
					audit_completed_time,
					can_work,
					cannot_work_cause,
					audit_user,
					track_km_length,
					audit_trackkm_length
				FROM
					common_task_workflow_420100
				WHERE
					work_get_time IS NOT NULL
			) a
		LEFT JOIN common_task_420100 m ON m.id = a.task_id
		LEFT JOIN (
			SELECT
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_cj_shtg,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_tj,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_sh,
				SUM(
					CASE
					WHEN a.task_type = 2
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS pmt_mc_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_shtg,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_tj,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS ld_dym_sh,
				SUM(
					CASE
					WHEN a.task_type = 1
					AND a.task_type_item = 2
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS ld_dym_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS nbl_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 1
					AND record_type = 1
					AND photo_url IS NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS nbl_shtg,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_tj,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result IS NOT NULL THEN
						1
					ELSE
						0
					END
				) AS tzd_sh,
				SUM(
					CASE
					WHEN a.task_type = 3
					AND a.task_type_item = 2
					AND photo_url IS NOT NULL
					AND a.audit_result = 1 THEN
						1
					ELSE
						0
					END
				) AS tzd_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						photo_url
					FROM
						common_task_data_420100
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							photo_url
						FROM
							common_task_data_history_420100
				) a
			GROUP BY
				task_id
		) task_item_item ON task_item_item.task_id = a.task_id
		LEFT JOIN (
			SELECT
				count(DISTINCT unit_number) AS ld_dym_tj,
				count(
					DISTINCT CASE
					WHEN audit_result IS NOT NULL THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_sh,
				count(
					DISTINCT CASE
					WHEN audit_result = 1 THEN
						unit_number
					ELSE
						NULL
					END
				) AS ld_dym_shtg,
				task_id
			FROM
				(
					SELECT
						task_id,
						workflow_id,
						task_type,
						task_type_item,
						audit_result,
						record_type,
						unit_number
					FROM
						common_task_data_420100
					WHERE
						photo_url IS NOT NULL
					AND task_type = 1
					AND task_type_item = 2
					UNION ALL
						SELECT
							task_id,
							workflow_id,
							task_type,
							task_type_item,
							audit_result,
							record_type,
							unit_number
						FROM
							common_task_data_history_420100
						WHERE
							photo_url IS NOT NULL
						AND task_type = 1
						AND task_type_item = 2
				) a
			GROUP BY
				task_id
		) task_item_item_dym ON task_item_item_dym.task_id = a.task_id
		LEFT JOIN (
			SELECT
				task_id,
				audit_result
			FROM
				mario_log.task_pass_cache
			WHERE
				city_code ='420100'
			AND audit_result = 1
		) b ON a.task_id = b.task_id
		LEFT JOIN (
			SELECT
				sum(period) AS period,
				user_id
			FROM
				mario_log.user_online_period
			WHERE
				1 = 1
			AND adcode ='420100'
			GROUP BY
				user_id
		) period ON period.user_id = work_user
		RIGHT JOIN app_user_info c ON c.username = work_user
		WHERE
			(
				m. ONLINE = 1
				OR m.id IN (
					SELECT
						task_id
					FROM
						common_task_workflow_420100
				)
			) 

		GROUP BY
			work_user
	) temp
WHERE
	1 = 1
LIMIT 0,
 20;
