CREATE TABLE IF NOT EXISTS customer (
    c_customer_sk bigint,
    c_customer_id char(16),
    c_current_cdemo_sk bigint,
    c_current_hdemo_sk bigint,
    c_current_addr_sk bigint,
    c_first_shipto_date_sk bigint,
    c_first_sales_date_sk bigint,
    c_salutation char(10),
    c_first_name char(20),
    c_last_name char(30),
    c_preferred_cust_flag char(1),
    c_birth_day integer,
    c_birth_month integer,
    c_birth_year integer,
    c_birth_country varchar(20),
    c_login char(13),
    c_email_address char(50),
    c_last_review_date_sk bigint,
    INDEX c_customer_sk_idx(c_customer_sk) COMMENT "c_customer_sk index",
    INDEX c_customer_id_idx(c_customer_id) USING INVERTED COMMENT "c_customer_id index",
    INDEX c_last_name_idx(c_last_name) USING INVERTED COMMENT "c_last_name index"

)
DUPLICATE KEY(c_customer_sk, c_customer_id)
DISTRIBUTED BY HASH(c_customer_id) BUCKETS 3
PROPERTIES (
  "replication_num" = "1"
)

