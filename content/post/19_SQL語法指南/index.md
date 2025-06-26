---
title: SQL 新手入門：一篇學會資料庫 CRUD，從基礎到進階！
description: 不懂 SQL 沒關係，用白話文帶你從零理解 SQL 與資料庫操作，重點 CRUD 一次學會，讓你資料處理技能大升級！
slug: sql-crud-guide
date: 2025-06-26 10:00:00+0000
image: sql-crud.png
categories:
- 資料庫
- 程式設計
- 新手教學
tags:
- SQL
- 資料庫
- CRUD
- 資料處理
weight:
---

## SQL 是什麼？為什麼學會它很重要？

當你在設計一個網站，想開發儲存「網站會員」、「銷售訂單」、「留言紀錄」等等資料時，絕大多數情境都會用到資料庫，而 SQL（**Structured Query Language**，結構化查詢語言）正是資料庫的通用語言。

不論你以後寫後端、做資料分析，甚至開發 APP，都會和 SQL 打交道。學會它，可以說是開啟資料世界的任意門。

---

## CRUD 是什麼 ? 

**CRUD 是資料庫最基本、也是最核心的資料操作流程，幾乎所有資料管理都圍繞著這四個動作進行。讓我們先來看一下 CRUD 分別有哪些 :**
- **C**reate：新增資料  
- **R**ead：查詢資料  
- **U**pdate：更新資料  
- **D**elete：刪除資料

也有人會記成「增、查、改、刪」。

---

CRUD 可分為「資料操作」和「資料結構操作」，可以把它想成「表格內容操作」和「表格本身操作」。
## CRUD 資料操作

### 常用 CRUD 關鍵字與語法對照表:

| **用途** | **關鍵字**        | **說明**        | **用途/功能**                                   | **範例語法**                           |
|----------|--------------|----------------|-------------------------------------------|-----------------------------------|
| C| `INSERT INTO`  | 插入到...表    | 把新資料「插入」某個表格                    | `INSERT INTO` users (name, age) ... |
| C | `VALUES`       | 資料值         | 搭配 INSERT INTO，後面放「要新增的資料」     | `VALUES` ('Amy', 25);               |
| R | `SELECT`       | 選擇/查詢      | 從資料表裡「查詢」你要的欄位或資料            | `SELECT` * `FROM` users;              |
| R | `FROM`         | 從哪個表       | 搭配 SELECT，指定「查詢來自哪一張表」        | `SELECT` name `FROM` users;           |
| U| `UPDATE`       | 更新           | 修改某一筆或多筆資料內容                     | `UPDATE` users `SET` age = 30 ...     |
| U | `SET`          | 設定           | 指定要修改哪些欄位/值                        | `SET` age = 30                      |
| D | `DELETE`       | 刪除           | 從資料表移除資料                             | `DELETE` `FROM` users ...             |
| 篩選條件 | `WHERE`        | 條件           | 設定篩選的條件，只操作特定資料                | `WHERE` age > 20                    |

> **小提醒 : 絕大多數開發團隊與專案的寫作習慣如下 (建議遵守) :**
>1. 關鍵字用大寫，如：SELECT、INSERT、FROM
>2. 表格和欄位名用小寫，單字用下底線連接（建議）
例：user_id, created_at
>3. 善用縮排與換行
>4. 複雜查詢分行排版更清楚
>5. 有條件時一定要加 WHERE，避免全表誤操作
>6. 用 `--` 單行註解說明每個步驟


---

假設有一個資料表名稱為 users ，搭配 CRUD關鍵字後，我們來看看要如何實際對資料進行操作。

#### 1️⃣ 新增資料（Create）

```sql
-- 新增一位使用者到 users 表格
INSERT INTO users (name, email, age)
VALUES ('Michelle', 'michelle@example.com', 26);

```

#### 2️⃣ 查詢資料（Read）

```sql
-- 查詢 users 表格中的所有資料
SELECT * FROM users;

-- 查詢年齡大於 20 歲的使用者姓名和信箱
SELECT name, email FROM users WHERE age > 20;

```

#### 3️⃣ 更新資料（Update）

```sql
-- 將名稱為 Michelle 的使用者年齡改為 27 歲
UPDATE users
SET age = 27
WHERE name = 'Michelle';
```

#### 4️⃣ 刪除資料（Delete）

```sql
-- 刪除名稱為 Michelle 的使用者資料
DELETE FROM users WHERE name = 'Michelle';
```
---

### 實用建議 : 善用條件關鍵字 `WHERE` 和 `SELECT`

在寫到 `UPDATE` 或是 `DELETE` 關鍵字時，新手很容易忘記設定後面條件，結果導致整個資料表的內容被意外「全部覆蓋」或「完全刪除」，這種情況下，我們一定要**記得使用`條件關鍵字`，最常見的就是`WHERE`。**

除此之外

在進行 `UPDATE` 或 `DELETE` 之前，可以先用 `SELECT` 指令把你要操作的資料選出來，確保範圍正確、條件沒有寫錯，之後再進行 `UPDATE` 或 `DELETE`，這樣可以大大降低誤刪或誤改資料的風險。

```sql
-- 先用 SELECT 測試條件正確
SELECT * FROM users WHERE age < 18;

-- 再進行 UPDATE 或 DELETE
UPDATE users SET status = 'underage' WHERE age < 18;
DELETE FROM users WHERE age < 18;
```
---

理解了如何操作「資料操作 (表格內的資料)」，我們當然也能透過其他關鍵字來操作「資料表結構 (表格的本身)」，下面是常用的關鍵字：
## CRUD 資料表結構操作（資料表/索引/檢視表結構）

| 關鍵字            | 中文說明      | 功能用途               | 範例                                      |
| -------------- | --------- | ------------------ | --------------------------------------- |
| CREATE TABLE   | 建立資料表     | 新建一個新的表格           | `CREATE TABLE users (...);`             |
| DROP TABLE     | 刪除資料表     | 永久刪除一個表格           | `DROP TABLE users;`                     |
| ALTER TABLE    | 修改資料表結構   | 增加/修改/刪除欄位或限制      | `ALTER TABLE users ADD COLUMN age INT;` |
| RENAME TABLE   | 重新命名資料表   | 把表格改名              | `RENAME TABLE users TO members;`        |
| TRUNCATE TABLE | 清空資料表     | 快速刪除「所有資料」，但保留表格結構 | `TRUNCATE TABLE users;`                 |
| CREATE INDEX   | 建立索引      | 在欄位上加索引加速查詢        | `CREATE INDEX idx_name ON users(name);` |
| DROP INDEX     | 刪除索引      | 把某個欄位的索引移除         | `DROP INDEX idx_name ON users;`         |
| CREATE VIEW    | 建立檢視表（視圖） | 建立一個虛擬表格           | `CREATE VIEW adult_users AS SELECT ...` |
| DROP VIEW      | 刪除檢視表     | 刪除虛擬表格             | `DROP VIEW adult_users;`                |


### 資料表結構 (範例)
```sql
-- 建立一個名為 users 的新資料表，含三個欄位
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

-- 永久刪除名為 users 的資料表（資料和結構都會消失）
DROP TABLE users;

-- 在 users 資料表中新增一個 age 欄位，型態為整數
ALTER TABLE users ADD COLUMN age INT;
```

>⚠️ 提醒：結構操作（如 DROP、ALTER、TRUNCATE）通常是不可逆的，執行前務必確認或備份資料表，以免資料損失！
---

## 常見新手 Q&A

### Q1. SQL 跟 MySQL、PostgreSQL、SQLite 有什麼不同？

 - **SQL** 是語言（用來操作資料庫的標準指令）；  
 - **MySQL/SQLite/PostgreSQL** 是資料庫軟體（支援 SQL 指令的系統）。  


### Q2. 那些 SQL 指令最常出錯？

- 欄位名稱拼錯（如 name 寫成 names）
- 單引號、逗號等符號忘記加
- 沒有 WHERE 條件，導致「全表」都被更改/刪除


### Q3. WHERE 條件沒寫，會怎樣？

- 沒有 `WHERE`，UPDATE/DELETE 會影響**全部資料**，超危險！  
    (永遠記得：操作前，`SELECT` 測試一下範圍，確保條件沒寫錯。)


### Q4. 資料型態要怎麼選？（TEXT、INTEGER、DATETIME…）

| **型態**       | **範例**                  | **適合存放**     |
| -------- | ------------------- | -------- |
| **TEXT**     | 'Amy', 'abc\@gmail' | 姓名、信箱、地址 |
| **INTEGER**  | 25, 99999           | 年齡、金額    |
| **REAL**     | 3.14, 29.95         | 價格、分數    |
| **DATETIME** | 2024-01-01 10:00:00 | 時間       |


```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT,              -- 名字，存文字
    email TEXT,             -- 電子信箱，存文字
    age INTEGER,            -- 年齡，存整數
    balance REAL,           -- 餘額，存小數
    created_at DATETIME     -- 註冊時間，存日期時間
);
```

---

## 腦力激盪

1. 請寫出一個 SQL 指令，查詢所有 email 結尾為 `@gmail.com` 的使用者。
2. 假設你想把所有年齡小於 18 歲的會員刪除，該怎麼寫？
3. 請問如果漏掉 `WHERE` 條件，`UPDATE` 或 `DELETE` 會發生什麼事？



---

(答案)


1. 請寫出一個 SQL 指令，查詢所有 email 結尾為 `@gmail.com` 的使用者。

```sql
SELECT * FROM users
WHERE email LIKE '%@gmail.com';
-- LIKE '%@gmail.com' 表示只找 email 以 @gmail.com 結尾的資料。
```
<br>

2. 假設你想把所有年齡小於 18 歲的會員刪除，該怎麼寫？

```sql
DELETE FROM users
WHERE age < 18;
```
<br>

3. 請問如果漏掉 `WHERE` 條件，`UPDATE` 或 `DELETE` 會發生什麼事？

- UPDATE 沒有 WHERE：所有資料都被更新。
- DELETE 沒有 WHERE：整個資料表資料都被刪除。
---
## 延伸

這篇只講了最重要的 CRUD。  
如果你已經搞懂，也歡迎繼續關注之後的文章：

- **JOIN 表連接**：怎麼查詢多個表的資料？
- **聚合函數**：SUM、COUNT、AVG 等實戰應用
- **索引/優化**：如何讓查詢更快？
- **資料庫設計原則**：避免資料重複與設計錯誤

---

