<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Home</title>
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
      crossorigin="anonymous"
    />
    <link
	  rel="stylesheet"
	  href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
	  integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay"
	  crossorigin="anonymous"
    />
    <link rel="stylesheet" href="/resources/css/styles.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="/resources/js/bootstrap.min.js" type="text/javascript"></script>
  </head>
  <body>
    <header>
        <h1 onclick="location.href='list'">Community</h1>
        <button
          type="button"
          data-toggle="modal"
          data-target="#signupModal"
          class="btn btn-secondary"
          id="register"
        >
          회원가입
        </button>
        <button
          type="button"
          data-toggle="modal"
          data-target="#loginModal"
          class="btn btn-outline-secondary"
          id="login"
        >
          로그인
        </button>
    </header>
    
    <!-- 로그인 -->
    <div class="modal fade memeber" id="loginModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="login-form">
              <form action="/examples/actions/confirmation.php" method="post">
                <div class="text-center social-btn">
                  <a href="#" class="btn btn-primary btn-block"
                    ><i class="fa fa-facebook"></i> Sign in with <b>Facebook</b></a
                  >
                  <a href="#" class="btn btn-info btn-block"
                    ><i class="fa fa-twitter"></i> Sign in with <b>Twitter</b></a
                  >
                  <a href="#" class="btn btn-danger btn-block"
                    ><i class="fa fa-google"></i> Sign in with <b>Google</b></a
                  >
                </div>
                <div class="or-seperator"><i>or</i></div>
                <div class="form-group">
                  
                    <input
                      type="text"
                      class="form-control"
                      name="username"
                      placeholder="Username"
                      required="required"
                    />

                </div>
                <div class="form-group">
                 
                    <input
                      type="password"
                      class="form-control"
                      name="password"
                      placeholder="Password"
                      required="required"
                    />

                </div>
                <div class="form-group">
                  <button type="submit" class="btn btn-success btn-block login-btn">Sign in</button>
                </div>
                <div class="clearfix">
                  <label class="pull-left checkbox-inline"
                    ><input type="checkbox" /> Remember me</label
                  >
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <div class="hint-text small">
                Don't have an account? <a href="#" class="text-success">Register Now!</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 회원가입 -->
    <div class="modal fade member" id="signupModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="signup-form">
              <form action="/examples/actions/confirmation.php" method="post">
                <div class="text-center social-btn">
                  <a href="#" class="btn btn-primary btn-block"
                    ><i class="fa fa-facebook"></i> Sign in with <b>Facebook</b></a
                  >
                  <a href="#" class="btn btn-info btn-block"
                    ><i class="fa fa-twitter"></i> Sign in with <b>Twitter</b></a
                  >
                  <a href="#" class="btn btn-danger btn-block"
                    ><i class="fa fa-google"></i> Sign in with <b>Google</b></a
                  >
                </div>
                <div class="or-seperator"><i>or</i></div>
                <div class="form-group">
                  <input
                    type="text"
                    class="form-control"
                    name="username"
                    placeholder="Username"
                    required="required"
                  />
                </div>
                <div class="form-group">
                  <input
                    type="email"
                    class="form-control"
                    name="email"
                    placeholder="Email Address"
                    required="required"
                  />
                </div>
                <div class="form-group">
                  <input
                    type="password"
                    class="form-control"
                    name="password"
                    placeholder="Password"
                    required="required"
                  />
                </div>
                <div class="form-group">
                  <input
                    type="password"
                    class="form-control"
                    name="confirm_password"
                    placeholder="Confirm Password"
                    required="required"
                  />
                </div>
                <div class="form-group">
                  <button type="submit" class="btn btn-primary btn-block btn-lg">Sign Up</button>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <div class="hint-text small">
                Already have an account?? <a href="#" class="text-success">Login here</a>
              </div>
              </div>
          </div>
        </div>
      </div>
    </div>