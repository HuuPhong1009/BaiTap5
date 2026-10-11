<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán thất bại</title>
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
            color: #dc3545;
        }
        h2 {
            color: #dc3545;
            margin-top: 0.5em;
        }
        p {
            color: #555;
            line-height: 1.6;
        }
        .reason {
            margin-top: 1.5em;
            padding: 1em;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            border-radius: 5px;
            text-align: left;
        }
        .actions {
            margin-top: 2em;
        }
        .action-button {
            display: inline-block;
            margin: 0.5em;
            padding: 0.8em 1.5em;
            background-color: #007bff;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .action-button:hover {
            background-color: #0056b3;
        }
        .contact-support {
            background-color: #6c757d;
        }
        .contact-support:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">
            <i class="fas fa-times-circle"></i>
        </div>
        <h2>Thanh toán thất bại!</h2>
        <p>Đã có lỗi xảy ra trong quá trình thanh toán. Vui lòng thử lại hoặc liên hệ với chúng tôi để được hỗ trợ.</p>
        <%
            String errorCode = request.getParameter("vnp_TransactionStatus");
            if (errorCode == null || errorCode.isEmpty()) {
                errorCode = request.getParameter("vnp_ResponseCode");
            }
            String message = "Lý do không xác định.";
            if (errorCode != null) {
                switch (errorCode) {
                    case "01": message = "Giao dịch chưa hoàn tất."; break;
                    case "02": message = "Giao dịch bị lỗi do thông tin thẻ/tài khoản không hợp lệ."; break;
                    case "04": message = "Giao dịch bị đảo (Khách hàng đã bị trừ tiền nhưng GD chưa thành công tại VNPAY)."; break;
                    case "05": message = "VNPAY đang xử lý giao dịch này (GD hoàn tiền)."; break;
                    case "06": message = "VNPAY đã gửi yêu cầu hoàn tiền sang Ngân hàng."; break;
                    case "07": message = "Trừ tiền thành công. Giao dịch bị nghi ngờ (liên quan tới fraud)."; break;
                    case "09": message = "Thẻ/Tài khoản chưa đăng ký dịch vụ Internet Banking tại ngân hàng."; break;
                    case "10": message = "Khách hàng xác thực thông tin thẻ/tài khoản không đúng quá 3 lần."; break;
                    case "11": message = "Đã hết hạn chờ thanh toán. Vui lòng thực hiện lại giao dịch."; break;
                    case "12": message = "Thẻ/Tài khoản của khách hàng bị khóa."; break;
                    case "13": message = "Khách hàng nhập sai mật khẩu xác thực giao dịch (OTP)."; break;
                    case "24": message = "Khách hàng hủy giao dịch."; break;
                    case "51": message = "Tài khoản của quý khách không đủ số dư để thực hiện giao dịch."; break;
                    case "65": message = "Tài khoản của quý khách đã vượt quá hạn mức giao dịch trong ngày."; break;
                    case "75": message = "Ngân hàng thanh toán đang bảo trì."; break;
                    case "79": message = "Khách hàng nhập sai mật khẩu thanh toán quá số lần quy định."; break;
                    default: message = "Mã lỗi phản hồi từ VNPay: " + errorCode; break;
                }
            }
        %>
        <div class="reason">
            <p><strong>Lý do:</strong> <%= message %></p>
        </div>
        <div class="actions">
            <a href="index.jsp" class="action-button">Thử lại</a>
            <a href="mailto:hotrovnpay@vnpay.vn" class="action-button contact-support">Liên hệ hỗ trợ</a>
        </div>
    </div>
</body>
</html>
