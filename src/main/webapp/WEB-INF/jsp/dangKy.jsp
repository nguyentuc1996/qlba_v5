<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html >
<head>
  <meta charset="UTF-8">
  <title>Sign-Up Form</title>
  <link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>

<body>
  <div id="header">
    <div class="inHeaderLogin"></div>
  </div>
  <div class="form">
    <div id="signup">
        <h1>Đăng ký tài khoản</h1>
        <form action="xylydangky" method="post">

            <div class="field-wrap">
                <label>
                Họ và tên<span class="req">*</span>
                </label>
                <input name="hoTen" type="text" required autocomplete="off" />
            </div>
        	<div class="field-wrap">
                <label>
                Tài khoản<span class="req">*</span>
                </label>
                <input name="taiKhoan" type="text" required autocomplete="off" />
            </div>
            <div class="field-wrap">
                <label>
                Email<span class="req">*</span>
                </label>
                <input name="email" type="email" required autocomplete="off"/>
            </div>

            <div class="field-wrap">
                <label>
                Mật khẩu<span class="req">*</span>
                </label>
                <input name="matKhau" type="password" id="password" required autocomplete="off"/>
            </div>

            <div class="field-wrap">
                <label>
                Xác nhận mật khẩu<span class="req">*</span>
                </label>
                <input name="matKhauXacNhan" type="password" id="confirm_password" required autocomplete="off"/>
                <span id='message'></span>
            </div>
			
            <button type="submit" class="button button-block" onclick="checkPW()"/>Tạo tài khoản</button>

        </form>

        </div>



  </div>
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

  <script  src="${pageContext.request.contextPath}/resources/js/index.js"></script>
  <script  src="${pageContext.request.contextPath}/resources/js/change-pwd.js"></script>

</body>
</html>
