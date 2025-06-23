---

title: 什麼是 API、REST、RESTful API？一次搞懂概念與實作原則
description: 本文深入解析什麼是 API、REST 與 RESTful API，說明它們的差異、關係與設計原則，並透過 HTTP 方法與 Django REST Framework 範例，幫助新手建立完整理解。
slug: what-is-restful-api
date: 2025-06-20 10:00:00+0800
image: restful_api_guide.png
categories:

- Web開發
- API設計
- Django
- Backend基礎

tags:

- RESTful
- HTTP
- Django REST Framework
- 前後端溝通
- API基礎

---
-------

## 什麼是 API？

**API（Application Programming Interface）** 是「應用程式之間溝通的橋樑」。

📦 比喻：
* 你 = 使用者（前端）
* 店員 = API
* 廚房 = 後端邏輯/資料庫

你只需要點餐（呼叫 API），店員會幫你處理後台的事情，然後回你食物（資料）！

> **(注意) API 不等於 REST，REST 是一種設計 API 的風格。**

---

## 什麼是 REST？

**REST（REpresentational State Transfer）** 是一種設計 API 的「規範」與「風格」，鼓勵使用「HTTP 方法 + 有語意的資源路徑（URL）」來操作資料。

REST 的資源設計非常直覺，例如：

* `/users/` 表示所有使用者
* `/users/1/` 表示 ID=1 的使用者
* `/posts/5/comments/` 表示第 5 篇貼文的留言

---

## 什麼是 RESTful API？

當你設計的 API 遵循 REST 的風格，就可以稱它為 **RESTful API**。

### 特徵：

* 路徑是「名詞」不是「動詞」
  ✅ `/users/1/`（好）
  ❌ `/getUserById?id=1`（壞）
* 行為交給 HTTP 方法（GET、POST、PUT、DELETE）
* 每次請求都是獨立的（Stateless）
* 回傳 JSON 格式資料（通常）

---

## HTTP 方法與 REST API 對應表

| 功能   | HTTP 方法  | 路徑範例            | 操作說明         |
| ---- | -------- | --------------- | ------------ |
| 查詢全部 | `GET`    | `/api/users/`   | 查詢所有使用者      |
| 查詢單筆 | `GET`    | `/api/users/1/` | 查詢 ID=1 的使用者 |
| 新增資料 | `POST`   | `/api/users/`   | 建立新使用者       |
| 完整更新 | `PUT`    | `/api/users/1/` | 完全覆蓋使用者資料    |
| 局部更新 | `PATCH`  | `/api/users/1/` | 只更新部分欄位      |
| 刪除資料 | `DELETE` | `/api/users/1/` | 刪除該使用者       |

---

## REST 的核心設計原則簡化版

| 原則名稱                  | 白話說明                    |
| --------------------- | ----------------------- |
| **Client-Server**     | 前後端分離，分工明確              |
| **Stateless**         | 每次請求都自帶資料，伺服器不會記住你      |
| **Cacheable**         | 可以快取的 API 要能標示出來        |
| **Uniform Interface** | 使用統一的 URL + 方法設計資源（核心）  |
| **Layered System**    | 前端不需知道後端架構幾層            |
| **Code on Demand**    | 可選：伺服器可以傳 JS 給前端執行（較少用） |

---

## Django REST API 對照範例

### ✅ 傳統 Django 表單方式

```python
@require_POST
def create_user(request):
    form = UserForm(request.POST)  # 從表單 POST 資料建立表單實例
    if form.is_valid():            # 驗證欄位是否合法
        form.save()                # 寫入資料庫
        return redirect("users:index")  # 成功後重新導向到其他頁面
```

### ✅ RESTful API（使用 Django REST Framework）

```python
@api_view(["POST"])
def create_user(request):
    serializer = UserSerializer(data=request.data)  # 從 JSON 資料建立序列化器
    if serializer.is_valid():                       # 驗證資料格式與規則
        serializer.save()                           # 將資料存入資料庫
        return Response(serializer.data, status=201)  # 回傳 JSON 資料與 HTTP 狀態碼
```

---

## 新手常見問題 Q\&A

### Q1：RESTful API 一定要用 JSON 嗎？

不是一定要，但 JSON 是最常見、跨平台友善、前端也好處理的格式。

### Q2：REST 是一種技術嗎？

不是，它是 API 的設計「風格」，不是一種程式語言或框架。

### Q3：HTTP 是 REST 的一部分嗎？

不是從屬關係，REST 通常是用 HTTP 實作而成。

### Q4：什麼是副作用？為什麼要避免在 GET 中發生？

副作用是指「會改變資料或狀態的行為」，例如新增、刪除或更新資料。REST 規範建議 GET 請求**只能讀取資料**，若 GET 執行寫入或刪除，可能導致安全風險與重複操作問題。

### Q5：RESTful API 的命名方式有什麼好處？

使用資源導向的 URL（如 `/users/1/`）搭配 HTTP 方法，可以讓 API 結構一致、語意清楚，利於維護與團隊溝通，也方便前端或第三方串接理解行為。

---

## 總結

> RESTful API 是一種讓前後端（或服務與服務之間）能夠透過 HTTP 協定交換資料的設計風格。
它通常用 JSON 傳輸資料，搭配像 GET / POST / PUT / DELETE 等標準 HTTP 方法，簡潔、清楚、可擴充。

| 名詞              | 定義                       |
| --------------- | ------------------------ |
| **API**         | 應用程式之間的溝通橋樑              |
| **REST**        | 設計 API 的風格與原則            |
| **RESTful API** | 遵循 REST 原則設計的 API        |
| **HTTP 方法**     | 操作 API 所用的語法（如 GET、POST） |

---

## 💬 腦力激盪：你學會了嗎？

1. 你覺得哪一個 URL 設計比較符合 REST 原則？

   * A. `/getUserById?id=3`
   * B. `/users/3/`

2. 如果要刪除 ID 為 10 的留言，你會：

   * A. 用 `POST /deleteComment/10`
   * B. 用 `DELETE /comments/10/`

歡迎留言你的答案，讓我們一起練習！

---
(答案)

|  | 正確選項                          | 原因說明                                                                          |
| -- | ----------------------------- | ----------------------------------------------------------------------------- |
| 1  | **B. `/users/3/`**            | RESTful 設計強調「資源導向」，應以名詞 `/users/` 表示資源，以 `/3/` 表示具體某個實體，不應使用動詞如 `getUserById` |
| 2  | **B. `DELETE /comments/10/`** | RESTful API 應使用 HTTP 方法語意表達動作，如刪除操作就使用 `DELETE`，不應用 `POST` + 動詞路徑去模擬          |

--- 
END

