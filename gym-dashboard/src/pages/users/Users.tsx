// Import necessary modules and components
import { GridColDef } from "@mui/x-data-grid";
import DataTable from "../../components/dataTable/DataTable";
import "./Users.scss";
import { useEffect, useState } from "react";
import Add from "../../components/add/Add";
import { User } from "../../types/user";
import { useUser } from "../../context/UserContext";

// Define columns for the data table
const columns: GridColDef[] = [
  {
    field: "user_id",
    headerName: "ID",
    width: 60,
  },
  {
    field: "profile_picture",
    headerName: "Profile",
    width: 100,
    renderCell: (params) => {
      return <img src={params.value || "/default-avatar.png"} alt="Profile" />;
    },
  },
  {
    field: "full_name",
    headerName: "Full Name",
    width: 100,
  },
  {
    field: "gender",
    headerName: "Gender",
    width: 60,
  },
  {
    field: "age",
    headerName: "Age",
    type: "number",
    width: 50,
  },
  {
    field: "email",
    headerName: "Email",
    width: 100,
  },
  {
    field: "phone_number",
    headerName: "Phone Number",
    width: 150,
  },
  {
    field: "aim",
    headerName: "Aim",
    width: 100,
  },
  {
    field: "activity_extent",
    headerName: "Activity Extent",
    width: 100,
  },
];

// Define the Users component
const Users = () => {
  // Initialize state variables using useState
  const [open, setOpen] = useState(false);
  const [data, setData] = useState<User[]>([]);
  const { user } = useUser(); // Assuming useUser is a custom hook for user authentication

  // Use the useEffect hook to fetch user data when the component mounts
  useEffect(() => {
    if (user && user.user.gym_id) {
      // Fetch user data for the specific gym_id
      fetch(`http://127.0.0.1:4500/api/gym/${user.user.gym_id}`)
        .then((response) => response.json())
        .then((responseData) => {
          // Check if responseData.data is an array
          if (Array.isArray(responseData.data)) {
            setData(responseData.data);
          } else {
            // If responseData.data is not an array, wrap it in an array
            setData([responseData.data]);
          }
        })
        .catch((error) => {
          console.error("Error fetching user data:", error);
        });
    }
  }, [user]);

  // Define a function to handle adding a new user
  const handleAddUser = (newUser: User) => {
    // Add a new user to the data state when the user is added
    setData((prevData) => [...prevData, newUser]);
  };

  // Render the component's JSX
  return (
    <div className="users">
      <div className="info">
        <h1>Users</h1>
        <button onClick={() => setOpen(true)}>Add New User</button>
      </div>
      <DataTable slug="users" columns={columns} rows={data} />
      {open && (
        <Add
          slug="user"
          columns={columns}
          setOpen={setOpen}
          onAddUser={handleAddUser}
        />
      )}
    </div>
  );
};

// Export the Users component as the default export
export default Users;
