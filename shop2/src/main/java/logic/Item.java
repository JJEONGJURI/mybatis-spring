package logic;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Item {
	private int id;
	@NotEmpty(message="상품명을 입력하세요") 
	//@NotEmpty : 값이 없거나 빈 문자열일 때 message 뜨게해줌
	private String name;
	@Min(value=10,message="10원이상 가능합니다")
	//@Min : 10 보다 작게 적으면 message 뜸
	@Max(value=100000,message="10만원이하만 가능합니다")
	private int price;
	@NotEmpty(message="상품설명을 입력하세요")
	private String description;
	private String pictureUrl;
	private MultipartFile picture; //picture file에서 업로드 된 파일 내용
}
