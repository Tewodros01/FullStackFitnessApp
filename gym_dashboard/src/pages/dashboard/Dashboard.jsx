import React, { useState, useEffect } from "react";
import Axios from "axios";
import "./Dashboard.css";

const Dashboard = () => {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    // Fetch the list of users from your API
    Axios.get("http://127.0.0.1:4500/api/users")
      .then((response) => {
        setUsers(response.data); // Update the users state with the fetched data
      })
      .catch((error) => {
        console.error(error);
      });
  }, []);

  return (
    <div className="dashboard">
      <div className="user-list">
        <h2>User List</h2>
        <ul>
          {users.map((user) => (
            <li key={user.id}>
              {user.name}
              <button className="user-button">View</button>
            </li>
          ))}
        </ul>
      </div>
      <div className="user-details">
        <h2>User Details</h2>
        {/* Display user details here when a user is selected */}
      </div>
    </div>
  );
};

export default Dashboard;
