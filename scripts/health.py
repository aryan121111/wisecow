import requests

url = "http://localhost:4499"

try:
    response = requests.get(url, timeout=5)

    if response.status_code == 200:
        print("Application is UP")
    else:
        print("Application is DOWN")

except Exception as e:
    print("Application is DOWN")
    print(e)