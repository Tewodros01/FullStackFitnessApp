import React, { useState } from "react";
import Axios from "axios";
import { Link, useNavigate } from "react-router-dom"; // Import useNavigate
import { FaUserShield } from "react-icons/fa";
import { AiOutlineSwapRight } from "react-icons/ai";
import { BsFillShieldLockFill } from "react-icons/bs";
import video from "../../assets/video.mp4";
import logo from "../../assets/logo.png";
import "./LogIn.css";
import "../../App.css";

const LogIn = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loginStatus, setLoginStatus] = useState(""); // State for login status
  const navigate = useNavigate(); // Use useNavigate instead of useHistory

  // To get the user entered data and attempt login
  const logInUser = async () => {
    try {
      const response = await Axios.post(
        "http://127.0.0.1:4500/api/users/login",
        {
          email: email,
          password: password,
        }
      );

      // Check if the login was successful based on the response (you can modify this condition)
      if (response.status === 200) {
        setLoginStatus("Login successful"); // Set login status to a success message
        // Redirect to the dashboard after successful login
        navigate("/dashboard");
      } else {
        setLoginStatus("Login failed"); // Set login status to a failure message
      }

      console.log(response.data);
    } catch (error) {
      console.error(error);
      setLoginStatus("Login error"); // Set login status to an error message
    }
  };

  return (
    <div className="loginPage flex">
      <div className="container flex">
        <div className="videoDiv">
          <video src={video} autoPlay muted loop></video>
          <div className="textDiv">
            <h2 className="title">Create And Get User</h2>
            <p>Adopt the peace of nature!</p>
          </div>
          <div className="footerDiv flex">
            <span className="text">Don't have an account</span>
            <Link to={"/register"}>
              <button className="btn">Sign UP</button>
            </Link>
          </div>
        </div>
        <div className="formDiv flex">
          <div className="headerDiv">
            <img src={logo} alt="" />
            <h3>Welcome Back!</h3>
          </div>
          <form action="" className="form grid">
            {/* Conditionally render the loginStatus based on its content */}
            {loginStatus && <span className="showMessage">{loginStatus}</span>}
            <div className="inputDiv">
              <label htmlFor="username">Username</label>
              <div className="input flex">
                <FaUserShield className="icon" />
                <input
                  type="text"
                  id="username"
                  placeholder="Enter Username"
                  onChange={(event) => {
                    setEmail(event.target.value);
                  }}
                />
              </div>
            </div>
            <div className="inputDiv">
              <label htmlFor="password">Password</label>
              <div className="input flex">
                <BsFillShieldLockFill className="icon" />
                <input
                  type="password"
                  id="password"
                  placeholder="Enter Password"
                  onChange={(event) => {
                    setPassword(event.target.value);
                  }}
                />
              </div>
            </div>
            <button type="button" className="btn flex" onClick={logInUser}>
              <span>Login</span>
              <AiOutlineSwapRight className="icon" />
            </button>
            <span className="forgotPassword">
              Forgot your password?<a href="">Click Here</a>
            </span>
          </form>
        </div>
      </div>
    </div>
  );
};

export default LogIn;
