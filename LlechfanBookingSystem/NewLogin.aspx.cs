using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace LlechfanBookingSystem
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        //database connection
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //search database with matching Membership ID's
            conn.Open();
            string checkuser = "select count(*) from users where MembershipID ='" + txtMemID.Text + "'";
            SqlCommand com = new SqlCommand(checkuser, conn);
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            conn.Close();

                if (temp == 1)
                {
                    conn.Open();
                    string sessionFirstNameQuery = "select Firstname from users where MembershipID ='" + txtMemID.Text + "'";
                    SqlCommand sessionFirstNameCom = new SqlCommand(sessionFirstNameQuery, conn);
                    string sessionSecondNameQuery = "select Surname from users where MembershipID ='" + txtMemID.Text + "'";
                    SqlCommand sessionSecondNameCom = new SqlCommand(sessionSecondNameQuery, conn);

                    string sessionName = sessionFirstNameCom.ExecuteScalar().ToString() + " " + sessionSecondNameCom.ExecuteScalar().ToString();

                    string checkPasswordQuery = "select Password from users where MembershipID ='" + txtMemID.Text + "'";
                    SqlCommand passCom = new SqlCommand(checkPasswordQuery, conn);
                    string password = passCom.ExecuteScalar().ToString().Replace(" ", "");
                    string checkRoleQuery = "select Role from users where MembershipID ='" + txtMemID.Text + "'";
                    SqlCommand roleCom = new SqlCommand(checkRoleQuery, conn);
                    string role = roleCom.ExecuteScalar().ToString();
                    conn.Close();

                    //variable of hashing passwords
                    string hashPassword = Encrypt(txtPassword.Text);

                    if (password == hashPassword)
                    {
                        if (role == "Admin")
                        {
                            Session["New"] = sessionName;
                            Session["id"] = txtMemID.Text;
                            Response.Redirect("~/Members/Admin.aspx");
                        }
                        else
                        {
                            Session["New"] = sessionName;
                            Session["id"] = txtMemID.Text;
                            Response.Redirect("~/Members/HomePage.aspx");
                        }
                    }
                    else
                    {
                    Response.Write("<script>alert('password is incorrect') </script>");
                    txtPassword.Text = "";
                }
            }
                else
                {
                Response.Write("<script>alert('Username is incorrect') </script>");
                txtMemID.Text = "";
                }
        }

        protected string Encrypt(string password)
        {
            //using the hash tool to convert the password to hash
            using (MD5CryptoServiceProvider hash = new MD5CryptoServiceProvider())
            {
                UTF8Encoding encode = new UTF8Encoding();
                byte[] encryptedPassword = hash.ComputeHash(encode.GetBytes(password));
                return Convert.ToBase64String(encryptedPassword);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Register.aspx");
        }
    }
}