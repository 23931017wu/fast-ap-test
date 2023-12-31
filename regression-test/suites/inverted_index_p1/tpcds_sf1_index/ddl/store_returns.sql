CREATE TABLE IF NOT EXISTS store_returns (
    sr_returned_date_sk bigint,
    sr_return_time_sk bigint,
    sr_item_sk bigint,
    sr_customer_sk bigint,
    sr_cdemo_sk bigint,
    sr_hdemo_sk bigint,
    sr_addr_sk bigint,
    sr_store_sk bigint,
    sr_reason_sk bigint,
    sr_ticket_number bigint,
    sr_return_quantity integer,
    sr_return_amt decimal(7,2),
    sr_return_tax decimal(7,2),
    sr_return_amt_inc_tax decimal(7,2),
    sr_fee decimal(7,2),
    sr_return_ship_cost decimal(7,2),
    sr_refunded_cash decimal(7,2),
    sr_reversed_charge decimal(7,2),
    sr_store_credit decimal(7,2),
    sr_net_loss decimal(7,2),
    INDEX sr_item_sk_idx(sr_item_sk) USING BITMAP COMMENT "sr_item_sk index",
    INDEX sr_ticket_number_idx(sr_ticket_number) USING INVERTED COMMENT "sr_ticket_number index",
    INDEX sr_return_quantity_idx(sr_return_quantity) USING INVERTED COMMENT "sr_return_quantity index"
)
DUPLICATE KEY(sr_returned_date_sk, sr_return_time_sk, sr_item_sk)
DISTRIBUTED BY HASH(sr_return_time_sk) BUCKETS 3
PROPERTIES (
  "replication_num" = "1"
)

