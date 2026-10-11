<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán thành công</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            box-sizing: border-box;
        }
        .container {
            background-color: #ffffff;
            padding: 2.5em 2em;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        .icon {
            font-size: 5em;
            color: #28a745;
        }
        h2 {
            color: #28a745;
            margin-top: 0.5em;
        }
        p {
            color: #555;
            line-height: 1.6;
        }
        .info {
            text-align: left;
            margin: 2em 0;
            border-top: 1px solid #eee;
            padding-top: 1em;
        }
        .info p {
            display: flex;
            justify-content: space-between;
            margin: 0.8em 0;
        }
        .info span {
            font-weight: bold;
        }
        .back-button {
            display: inline-block;
            margin-top: 1.5em;
            padding: 0.8em 1.5em;
            background-color: #007bff;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <h2>Thanh toán thành công!</h2>
        <p>Cảm ơn bạn đã hoàn tất thanh toán. Giao dịch của bạn đã được xử lý thành công.</p>
        <%
            String txnRef = request.getParameter("vnp_TxnRef");
            String amountParam = request.getParameter("vnp_Amount");
            String formattedAmount = "0";
            if (amountParam != null && !amountParam.isEmpty()) {
                try {
                    long amount = Long.parseLong(amountParam) / 100;
                    formattedAmount = String.format("%,d", amount);
                } catch (Exception ignored) {}
            }
            String orderInfo = request.getParameter("vnp_OrderInfo");
            String bankCode = request.getParameter("vnp_BankCode");
            String payDateParam = request.getParameter("vnp_PayDate");
            String formattedDate = "N/A";
            if (payDateParam != null && payDateParam.length() == 14) {
                try {
                    formattedDate = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(
                        new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(payDateParam)
                    );
                } catch (Exception ignored) {
                    formattedDate = payDateParam;
                }
            }
        %>
        <div class="info">
            <p><span>Mã giao dịch:</span> <%= (txnRef != null) ? txnRef : "N/A" %></p>
            <p><span>Số tiền:</span> <%= formattedAmount %> VND</p>
            <p><span>Nội dung:</span> <%= (orderInfo != null) ? orderInfo : "N/A" %></p>
            <p><span>Mã ngân hàng:</span> <%= (bankCode != null) ? bankCode : "NCB" %></p>
            <p><span>Thời gian:</span> <%= formattedDate %></p>
        </div>
        <a href="index.jsp" class="back-button">Quay lại trang chủ</a>
    </div>
</body>
</html>
