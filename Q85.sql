DROP TABLE IF EXISTS conversation;
CREATE TABLE conversation
(
    senderDeviceType VARCHAR(20),   -- '... Customer' or '... Agent'
    customerId       INT,
    orderId          VARCHAR(10),
    resolution       VARCHAR(10),   -- 'True' / 'False'
    agentId          INT,
    messageSentTime  DATETIME,
    cityCode         VARCHAR(6)
);

-- Sample rows
INSERT INTO conversation
(senderDeviceType, customerId, orderId, resolution, agentId, messageSentTime, cityCode)
VALUES
-- Order 59528555 (one agent, resolved)
('Android Customer', 17071099, '59528555', 'False', 16293039, '2019-08-19 08:00:05', 'BGL001'),
('Web Agent',        17071099, '59528555', 'False', 16293039, '2019-08-19 08:01:10', 'BGL001'),
('Android Customer', 17071099, '59528555', 'True',  16293039, '2019-08-19 09:15:20', 'BGL001'),

-- Order 59528083 (one agent only, not resolved)
('Web Agent',        12874122, '59528083', 'False', 18325287, '2019-08-19 07:59:45', 'MUM002'),
('Web Agent',        12874122, '59528083', 'False', 18325287, '2019-08-19 08:05:00', 'MUM002'),

-- Order 59528556 (two agents → reassigned)
('Android Customer', 87654321, '59528556', 'False', 12345678, '2019-08-20 10:15:05', 'DEL003'),
('Web Agent',        87654321, '59528556', 'False', 87654321, '2019-08-20 10:16:40', 'DEL003'),
('Web Agent',        87654321, '59528556', 'False', 76543210, '2019-08-20 10:20:00', 'DEL003'),

-- Order 59528557 (one agent, not resolved)
('Web Agent',        98765432, '59528557', 'False', 98765432, '2019-08-21 09:30:00', 'HYD004'),
('Android Customer', 24681357, '59528557', 'False', 98765432, '2019-08-21 09:32:10', 'HYD004'),

-- Order 59528558 (one agent & customer, resolved)
('Android Customer', 22334455, '59528558', 'False', 11221122, '2019-08-22 11:00:00', 'PUN005'),
('Web Agent',        22334455, '59528558', 'True',  11221122, '2019-08-22 11:03:00', 'PUN005');

WITH conv AS
(
  SELECT  c.orderId,
          MIN(CASE WHEN c.senderDeviceType LIKE '%Agent%'    THEN c.messageSentTime END)
                AS first_agent_message,
          MIN(CASE WHEN c.senderDeviceType LIKE '%Customer%' THEN c.messageSentTime END)
                AS first_customer_message,
          SUM(CASE WHEN c.senderDeviceType LIKE '%Agent%'    THEN 1 ELSE 0 END)
                AS num_messages_agent,
          SUM(CASE WHEN c.senderDeviceType LIKE '%Customer%' THEN 1 ELSE 0 END)
                AS num_messages_customer,
          MIN(c.cityCode)                                                AS city_code,     -- unique per order
          MAX(CASE WHEN c.resolution = 'True' THEN 1 ELSE 0 END)         AS resolved,
          CASE WHEN COUNT(DISTINCT CASE WHEN c.senderDeviceType LIKE '%Agent%'
                                        THEN c.agentId END) > 1
               THEN 1 ELSE 0 END                                        AS reassigned
  FROM conversation c
  GROUP BY c.orderId
)
SELECT  orderId AS order_id,
        city_code,
        first_agent_message,
        first_customer_message,
        num_messages_agent,
        num_messages_customer,
        CASE
          WHEN first_agent_message IS NOT NULL
               AND (first_customer_message IS NULL
                    OR first_agent_message <= first_customer_message)
                THEN 'agent'
          ELSE 'customer'
        END AS first_message_by,
        resolved,
        reassigned
FROM conv
ORDER BY order_id;
