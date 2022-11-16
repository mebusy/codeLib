import websocket
import ssl
try:
    import thread
except ImportError:
    import _thread as thread
import time

def on_message(ws, message):
    print(message)

def on_error(ws, error):
    print(error)

def on_close(ws):
    print("### closed ###")

def on_open(ws):
    def run(*args):
        # for i in range(3):
        cnt = 0 
        while True:
            time.sleep(5)
            ws.send("Hello {}".format( cnt ) )
            cnt +=1
        time.sleep(1)
        ws.close()
        print("thread terminating...")
    thread.start_new_thread(run, ())


if __name__ == "__main__":
    websocket.enableTrace(True)
    ws = websocket.WebSocketApp(
                # "ws://10.192.81.132:5001/wss",
                # "wss://10.192.81.132/wss",
                "wss://dev-ballrace.upaidui.com/wss",
                              on_message = on_message,
                              on_error = on_error,
                              on_close = on_close)
    ws.on_open = on_open
    ws.run_forever( sslopt={"cert_reqs": ssl.CERT_NONE}  )

