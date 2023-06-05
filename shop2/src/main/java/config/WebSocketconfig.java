package config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import websocket.EchoHandler;

@Configuration
@EnableWebSocket	//웹소켓 사용할거니까 처리해줘.
public class WebSocketconfig implements WebSocketConfigurer {
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(new EchoHandler(),"chatting")
		.setAllowedOrigins("*"); //브라우저환경
		
	}
}
