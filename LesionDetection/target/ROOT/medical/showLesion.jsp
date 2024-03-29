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
<%//@page errorPage='../error.jsp' %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../partSelector/index.css">
        <link rel="stylesheet" href="../mainstyle.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

        <title>Show Lesion</title>
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
        <input type="hidden" id="akiec" value="<%=dx.akiec%>">
        <input type="hidden" id="bcc" value="<%=dx.bcc%>">
        <input type="hidden" id="bkl" value="<%=dx.bkl%>">
        <input type="hidden" id="nv" value="<%=dx.nv%>">
        <input type="hidden" id="mel" value="<%=dx.mel%>">
        <input type="hidden" id="df" value="<%=dx.df%>">
        <input type="hidden" id="vasc" value="<%=dx.vasc%>">
        <form action="saveRecord.jsp" id="dxForm">
            <input type="hidden" name="id" value="<%=lesion.getId()%>">
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
                        <b>AI Diagnosis: </b><%=Classification.allClass().get(dx.prediction)%>/<%=Classification.likelyBenign(dx.prediction)%>
                        <br>
                        <b>Breakdown: </b>
                        <br>
                        <div id="dxPie" style="width: 400px;"></div>
                        <br>
                        <b>Description: </b>
                        <br>
                        <textarea name="description" cols="40" rows="5"><%=Var.varNull(lesion.description)%></textarea>
                        <br>
                        <b>Diagnosis: </b>
                        <select name="diagnosis">
                            <option>--</option>
                            <option value="akiec" <%=Var.sel("akiec", Var.varNull(dx.doctorDx))%>><%=Classification.allClass().get("akiec")%></option>
                            <option value="bcc" <%=Var.sel("bcc", Var.varNull(dx.doctorDx))%>><%=Classification.allClass().get("bcc")%></option>
                            <option value="bkl" <%=Var.sel("bkl", Var.varNull(dx.doctorDx))%>><%=Classification.allClass().get("bkl")%></option>
                            <option value="nv" <%=Var.sel("nv", Var.varNull(dx.doctorDx))%>><%=Classification.allClass().get("nv")%></option>
                            <option value="mel" <%=Var.sel("mel", Var.varNull(dx.doctorDx))%>><%=Classification.allClass().get("mel")%></option>
                            <option value="df" <%=Var.sel("df", Var.varNull(dx.doctorDx))%>><%=Classification.allClass().get("df")%></option>
                            <option value="vasc" <%=Var.sel("vasc", Var.varNull(dx.doctorDx))%>><%=Classification.allClass().get("vasc")%></option>
                            <option value="inco">Inconclusive (Follow Up)</option>
                        </select>
                        <br>
                    </td>
                </tr>
            </table>
            <button class="btn btn-primary btn-sm" style="background-color: green;" type="button" onclick="confirmDx()">Submit Diagnosis</button>
            <button class="btn btn-warning btn-sm" onclick="window.history.back()">Back</button>

        </form>

        <jsp:include page="../footer.jsp" flush="true" />
    </body>
</html>
