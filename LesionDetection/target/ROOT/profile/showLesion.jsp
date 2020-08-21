<%-- 
    Document   : showLesion
    Created on : Aug. 20, 2020, 9:32:51 p.m.
    Author     : nickm
--%>

<%@page import="com.skindeep.db.Diagnosis"%>
<%@page import="com.microsoft.azure.cognitiveservices.vision.customvision.samples.Classification"%>
<%@page import="utils.Var"%>
<%@page import="com.skindeep.db.LesionEntry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../partSelector/index.css">
        <link rel="stylesheet" href="../mainstyle.css">
        <title>Show Lesion</title>
    </head>
    <body>
        <jsp:include page="../header.jsp" flush="true" />
        <%
            Diagnosis dx = new Diagnosis();
            LesionEntry lesion = new LesionEntry();

            try {
                lesion.find(Var.parseInt(request.getParameter("id")));
                dx.findByLesion(lesion.getId());
            } catch (Exception e) {
                throw new JspException("Could not find lesion data. Please try again");
            }
        %>
        <table style="width: 100%;">
            <tr>
                <td><img src="<%=lesion.image%>" style="max-width: 300px;"></td>
                <td>
                    <b>Body Part: </b> <%=lesion.bodyPart%>
                    <br>
                    <b>Date Noticed: </b><%=lesion.dateNoticed.toFullShow()%>
                    <br>
                    <b>Date Logged: </b><%=lesion.dateLogged.toFullShow()%>
                    <br>
                    <% if (lesion.diagnosed) {%>
                    <b>Diagnosis: </b><%=Classification.allClass().get(dx.doctorDx)%>
                    <br>
                    <b>Description: </b><br><%=lesion.description%>
                    <br>
                    <% if (dx.verified) {%>
                    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

                    <script type="text/javascript">
                        google.charts.load('current', {'packages': ['corechart']});
                        google.charts.setOnLoadCallback(drawChart);
                        function drawChart() {
                            var data = google.visualization.arrayToDataTable([
                                ['Diagnosis', 'Percentage of Liklihood'],
                                ['<%=Classification.allClass().get("akiec")%>', parseFloat(document.getElementById("akiec").value)],
                                ['<%=Classification.allClass().get("bcc")%>', parseFloat(document.getElementById("bcc").value)],
                                ['<%=Classification.allClass().get("bkl")%>', parseFloat(document.getElementById("bkl").value)],
                                ['<%=Classification.allClass().get("nv")%>', parseFloat(document.getElementById("nv").value)],
                                ['<%=Classification.allClass().get("mel")%>', parseFloat(document.getElementById("mel").value)],
                                ['<%=Classification.allClass().get("df")%>', parseFloat(document.getElementById("df").value)],
                                ['<%=Classification.allClass().get("vasc")%>', parseFloat(document.getElementById("vasc").value)]
                            ]);

                            var options = {
                                title: 'AI Diagnosis',
                                pieHole: 0.4,
                            };

                            var chart = new google.visualization.PieChart(document.getElementById('dxPie'));
                            chart.draw(data, options);
                        }

                        function confirmDx() {
                            if (confirm("Are you sure you wish to submit this diagnosis?")) {
                                document.getElementById("dxForm").submit();
                            }
                        }
                    </script>
                    <input type="hidden" id="akiec" value="<%=dx.akiec%>">
                    <input type="hidden" id="bcc" value="<%=dx.bcc%>">
                    <input type="hidden" id="bkl" value="<%=dx.bkl%>">
                    <input type="hidden" id="nv" value="<%=dx.nv%>">
                    <input type="hidden" id="mel" value="<%=dx.mel%>">
                    <input type="hidden" id="df" value="<%=dx.df%>">
                    <input type="hidden" id="vasc" value="<%=dx.vasc%>">
                    <div id="dxPie" style="width: 400px;"></div>

                    <br>
                    <button class='btn btn-primary' type='button' onclick="window.location.href = 'makeAppointment.jsp'">Make Appointment</button>
                    <button class="btn btn-warning btn-sm" onclick="window.history.back()">Back</button>

                    <% }
                        }%>
                </td>
            </tr>
        </table>

        <jsp:include page="../footer.jsp" flush="true" />
    </body>
</html>
