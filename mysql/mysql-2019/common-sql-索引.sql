

-- 添加索引
ALTER TABLE wm_receipt_order_head ADD INDEX index_warehouse_code USING BTREE ( warehouse_code);
ALTER TABLE wm_receipt_order_detail ADD INDEX index_warehouse_code USING BTREE ( warehouse_code);
DROP INDEX index_warehouse_code ON  wm_receipt_order_head;
