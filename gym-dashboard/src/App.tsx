import React from "react";
import {
  createBrowserRouter,
  RouterProvider,
  useNavigate,
} from "react-router-dom";
import Layout from "./Layout";
import Home from "./pages/home/Home";
import RegisterGym from "./pages/register/Register";
import LogIn from "./pages/login/Login";
import { UserProvider, useUser } from "./context/UserContext";
import Users from "./pages/users/Users";
import User from "./pages/user/User";
import Posts from "./pages/posts/Posts";
import Post from "./pages/post/Post";
import "./styles/global.scss";

// Define the main App component
const App: React.FC = () => {
  // Use the useUser hook to access the user context
  // const { user } = useUser();
  // // Use the useNavigate hook to get the navigation function
  // const navigate = useNavigate();
  // // Log the user data to the console for debugging
  // console.log("User:", user);
  // // Check if the user is not logged in or registered successfully
  // if (!user) {
  //   // Redirect to the login page if the user is not authenticated
  //   navigate("/login");
  //   // Return null or a loading indicator while redirecting
  //   return null;
  // }
  // Create a router configuration using createBrowserRouter
  const router = createBrowserRouter([
    // Define your route configuration here
    {
      path: "/",
      element: <Layout />,
      children: [
        {
          index: true,
          element: <Home />,
        },
        {
          path: "/users",
          element: <Users />,
        },
        {
          path: "/users/:id",
          element: <User />,
        },
        {
          path: "/posts",
          element: <Posts />,
        },
        {
          path: "/posts/:id",
          element: <Post />,
        },
      ],
    },
    {
      path: "/login",
      element: <LogIn />,
    },
    {
      path: "/register",
      element: <RegisterGym />,
    },
  ]);
  // Return the main component tree wrapped in RouterProvider
  return (
    <UserProvider>
      <RouterProvider router={router}></RouterProvider>
    </UserProvider>
  );
};
// Export the App component as the default export
export default App;
