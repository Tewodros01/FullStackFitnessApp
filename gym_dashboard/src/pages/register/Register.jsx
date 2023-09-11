import React, { useState } from "react";
import Axios from "axios";
import { Link } from "react-router-dom";
import { FaUserShield } from "react-icons/fa";
import { MdEmail } from "react-icons/md";
import { AiOutlineSwapRight } from "react-icons/ai";
import { BsFillShieldLockFill } from "react-icons/bs";
import video from "../../assets/video.mp4";
import logo from "../../assets/logo.png";
import "./Register.css";
import "../../App.css";

const Register = () => {
  const [email, setEmail] = useState("");
  const [userName, setUserName] = useState("");
  const [password, setPassword] = useState("");
  const [registrationStatus, setRegistrationStatus] = useState(""); // State for registration status

  // Function to create a new user
  const createUser = async () => {
    try {
      const response = await Axios.post(
        "http://127.0.0.1:4500/api/users/register",
        {
          email: email,
          userName: userName,
          password: password,
        }
      );

      // Check if registration was successful based on the response (you can modify this condition)
      if (response.status === 201) {
        setRegistrationStatus("Registration successful"); // Set registration status to a success message
      } else {
        setRegistrationStatus("Registration failed"); // Set registration status to a failure message
      }

      console.log("User has been created");
    } catch (error) {
      console.error(error);
      setRegistrationStatus("Registration error"); // Set registration status to an error message
    }
  };

  return (
    <div className="registerPage flex">
      <div className="container flex">
        <div className="videoDiv">
          <video src={video} autoPlay muted loop></video>
          <div className="textDiv">
            <h2 className="title">Create And Get User</h2>
            <p>Adopt the peace of nature!</p>
          </div>
          <div className="footerDiv flex">
            <span className="text">Have an account?</span>
            <Link to={"/"}>
              <button className="btn">Login</button>
            </Link>
          </div>
        </div>
        <div className="formDiv flex">
          <div className="headerDiv">
            <img src={logo} alt="" />
            <h3>Welcome Back!</h3>
          </div>
          <form action="" className="form grid">
            {/* Conditionally render the registration status based on its content */}
            {registrationStatus && (
              <span className="showMessage">{registrationStatus}</span>
            )}

            <div className="inputDiv">
              <label htmlFor="username">Username</label>
              <div className="input flex">
                <FaUserShield className="icon" />
                <input
                  type="text"
                  id="username"
                  placeholder="Enter Username"
                  onChange={(event) => {
                    setUserName(event.target.value);
                  }}
                />
              </div>
            </div>

            <div className="inputDiv">
              <label htmlFor="email">Email</label>
              <div className="input flex">
                <MdEmail className="icon" />
                <input
                  type="text"
                  id="email"
                  placeholder="Enter Email"
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

            <button type="button" className="btn flex" onClick={createUser}>
              <span>Register</span>
              <AiOutlineSwapRight className="icon" />
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Register;
