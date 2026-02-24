<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bank Account Opening Form</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }

        .container {
            width: 900px;
            margin: auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
        }

        h2 {
            background: #0b5ed7;
            color: #ffffff;
            padding: 10px;
        }

        table {
            width: 100%;
        }

        td {
            padding: 8px;
        }

        input,
        select {
            width: 95%;
            padding: 6px;
        }

        .section {
            background: #e9ecef;
            font-weight: bold;
        }

        .submit-btn {
            background: #198754;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
        }
        .section {
    margin-top: 20px;
}

.section h3 {
    background-color: #e6f0ff;
    padding: 8px;
    font-size: 16px;
}

.facility-row {
    margin: 8px 0;
}

.facility-row label {
    display: flex;
    align-items: center;
    font-size: 14px;
}

.facility-row input[type="checkbox"] {
    margin-right: 10px;
}
        
    </style>
</head>

<body>

<div class="container">

    <form action="RegisterUserServlet"
          method="post"
          enctype="multipart/form-data">

        <h2>🏦 Bank Account Opening Form</h2>

        <table>

            <!-- 1️⃣ BASIC PERSONAL DETAILS -->
            <tr class="section">
                <td colspan="4">1️⃣ Basic Personal Details</td>
            </tr>

            <tr>
                <td>Full Name</td>
                <td>
                    <input type="text" name="full_name" required>
                </td>

                <td>Guardian Name</td>
                <td>
                    <input type="text" name="guardian_name">
                </td>
            </tr>

            <tr>
                <td>Date of Birth</td>
                <td>
                    <input type="date" name="dob">
                </td>

                <td>Gender</td>
                <td>
                    <select name="gender">
                        <option value="MALE">Male</option>
                        <option value="FEMALE">Female</option>
                        <option value="OTHER">Other</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td>Marital Status</td>
                <td>
                    <select name="marital_status">
                        <option value="SINGLE">Single</option>
                        <option value="MARRIED">Married</option>
                    </select>
                </td>

                <td>Nationality</td>
                <td>
                    <input type="text" name="nationality" value="Indian">
                </td>
            </tr>

            <!-- 2️⃣ CONTACT DETAILS -->
            <tr class="section">
                <td colspan="4">2️⃣ Contact Details</td>
            </tr>

            <tr>
                <td>Mobile Number</td>
                <td>
                    <input type="text" name="mobile" required>
                </td>

                <td>Email ID</td>
                <td>
                    <input type="email" name="email">
                </td>
            </tr>

            <tr>
                <td>House No</td>
                <td>
                    <input type="text" name="house_no">
                </td>

                <td>Area / Locality</td>
                <td>
                    <input type="text" name="area">
                </td>
            </tr>

            <tr>
                <td>City</td>
                <td>
                    <input type="text" name="city">
                </td>

                <td>State</td>
                <td>
                    <input type="text" name="state">
                </td>
            </tr>

            <tr>
                <td>Pincode</td>
                <td>
                    <input type="text" name="pincode">
                </td>
                <td></td>
                <td></td>
            </tr>

            <!-- 3️⃣ KYC DETAILS -->
            <tr class="section">
                <td colspan="4">3️⃣ Identity & KYC Details</td>
            </tr>

            <tr>
                <td>Aadhaar Number</td>
                <td>
                    <input type="text" name="aadhaar_no">
                </td>

                <td>PAN Number</td>
                <td>
                    <input type="text" name="pan_no">
                </td>
            </tr>

            <tr>
                <td>Passport No</td>
                <td>
                    <input type="text" name="passport_no">
                </td>

                <td>Voter ID</td>
                <td>
                    <input type="text" name="voter_id">
                </td>
            </tr>

            <!-- 4️⃣ ACCOUNT DETAILS -->
            <tr class="section">
                <td colspan="4">4️⃣ Account Details</td>
            </tr>

            <tr>
                <td>Account Type</td>
                <td>
                    <select name="account_type">
                        <option>SAVINGS</option>
                        <option>CURRENT</option>
                        <option>SALARY</option>
                        <option>FD</option>
                    </select>
                </td>

                <td>Mode of Operation</td>
                <td>
                    <select name="mode_of_operation">
                        <option>SELF</option>
                        <option>JOINT</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td>Initial Deposit</td>
                <td>
                    <input type="number" name="initial_deposit">
                </td>
                <td></td>
                <td></td>
            </tr>

            <!-- 5️⃣ NOMINEE DETAILS -->
            <tr class="section">
                <td colspan="4">5️⃣ Nominee Details</td>
            </tr>

            <tr>
                <td>Nominee Name</td>
                <td>
                    <input type="text" name="nominee_name">
                </td>

                <td>Relation</td>
                <td>
                    <input type="text" name="nominee_relation">
                </td>
            </tr>

            <tr>
                <td>Nominee DOB</td>
                <td>
                    <input type="date" name="nominee_dob">
                </td>

                <td>Nominee Address</td>
                <td>
                    <input type="text" name="nominee_address">
                </td>
            </tr>

            <!-- 6️⃣ OCCUPATION & INCOME -->
            <tr class="section">
                <td colspan="4">6️⃣ Occupation & Income</td>
            </tr>

            <tr>
                <td>Occupation</td>
                <td>
                    <select name="occupation">
                        <option>STUDENT</option>
                        <option>PRIVATE_JOB</option>
                        <option>GOVT_JOB</option>
                        <option>BUSINESS</option>
                        <option>SELF_EMPLOYED</option>
                    </select>
                </td>

                <td>Annual Income</td>
                <td>
                    <select name="annual_income">
                        <option>LESS_THAN_1L</option>
                        <option>1_TO_5L</option>
                        <option>5_TO_10L</option>
                        <option>ABOVE_10L</option>
                    </select>
                </td>
            </tr>

            <!-- 7️⃣ BANKING FACILITIES -->
            <tr class="section">
                <td colspan="4">7️⃣ Banking Facilities</td>
            </tr>

            <tr>
                <td colspan="4">
                    <input type="checkbox" name="atm_card"> ATM Card
                    <input type="checkbox" name="cheque_book"> Cheque Book
                    <input type="checkbox" name="net_banking"> Net Banking
                    <input type="checkbox" name="mobile_banking"> Mobile Banking
                    <input type="checkbox" name="sms_alert"> SMS Alert
                </td>
            </tr>

            <!-- 8️⃣ PHOTO & SIGNATURE -->
            <tr class="section">
                <td colspan="4">8️⃣ Upload Photo & Signature</td>
            </tr>

            <tr>
                <td>Photo</td>
                <td>
                    <input type="file" name="photo">
                </td>

                <td>Signature</td>
                <td>
                    <input type="file" name="signature">
                </td>
            </tr>

            <!-- 9️⃣ DECLARATION -->
            <tr class="section">
                <td colspan="4">9️⃣ Declaration</td>
            </tr>

            <tr>
                <td colspan="4">
                    <input type="checkbox" name="declaration" required>
                    I declare that all the information provided is correct
                    and I agree to the bank rules.
                </td>
            </tr>

            <tr>
                <td colspan="4" align="center">
                    <button type="submit" class="submit-btn">
                        Submit Application
                    </button>
                </td>
            </tr>

        </table>

    </form>

</div>

</body>
</html>
