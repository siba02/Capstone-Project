
from flask import Flask, request
import socket
import time

app = Flask(__name__)

start_time = time.time()
request_count = 0


@app.route("/")
def dashboard():
    global request_count
    request_count += 1

    uptime = int(time.time() - start_time)

    with open("index.html") as f:
        html = f.read()

    html = html.replace("{{POD_NAME}}", socket.gethostname())
    html = html.replace("{{CLIENT_IP}}", request.remote_addr)
    html = html.replace("{{REQUEST_COUNT}}", str(request_count))
    html = html.replace("{{UPTIME}}", str(uptime))

    return html


@app.route("/health")
def health():
    return {"status": "UP"}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)












# from flask import Flask, request, Response
# import socket
# import time

# app = Flask(__name__)

# request_count = 0
# start_time = time.time()

# @app.route("/")
# def index():
#     global request_count
#     request_count += 1

#     uptime = int(time.time() - start_time)

#     with open("index.html", "r") as f:
#         html = f.read()

#     html = html.replace("{{POD_NAME}}", socket.gethostname())
#     html = html.replace("{{CLIENT_IP}}", request.remote_addr)
#     html = html.replace("{{REQUEST_COUNT}}", str(request_count))
#     html = html.replace("{{UPTIME}}", str(uptime))

#     return html


# @app.route("/health")
# def health():
#     return {"status": "UP"}


# @app.route("/metrics")
# def metrics():
#     uptime = int(time.time() - start_time)

#     metrics_data = f"""
# # HELP telcocloud_requests_total Total HTTP requests
# # TYPE telcocloud_requests_total counter
# telcocloud_requests_total {request_count}

# # HELP telcocloud_uptime_seconds Application uptime
# # TYPE telcocloud_uptime_seconds gauge
# telcocloud_uptime_seconds {uptime}
# """
#     return Response(metrics_data, mimetype="text/plain")


# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=80)