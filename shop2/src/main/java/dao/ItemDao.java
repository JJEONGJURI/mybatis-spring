package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ItemMapper;
import logic.Item;

@Repository
//@Repository(연속객체) = @Component(객체생성) + dao 기능(데이터베이스 연결)
//spring-mvc.xml 에서 <context:component-scan base-package="controller,logic,dao"> 때문에 전부 객체 생성 가능
public class ItemDao {
	@Autowired
	private SqlSessionTemplate template; //spring-db.xml 에 있음 . //org.mybatis.spring.SqlSessionTemplate 객체 주입
	private Map<String,Object> param = new HashMap<>(); //파라미터 전송할 때 쓸거임
	private final Class<ItemMapper> cls = ItemMapper.class;

	public List<Item> list() {
		param.clear();
		return template.getMapper(cls).select(param);	//item 테이블의 전체 내용을 Item 객체의 목록 리턴	
	}
	public Item getItem(Integer id) {
		param.clear();
		param.put("id", id);
	//	return template.getMapper(cls).select(param);	//item 테이블의 전체 내용을 Item 객체의 목록 리턴	
		//List 와 리턴타입이 달라서 에러남 . .get(0) 
	//	return template.getMapper(cls).select(param).get(0);	//item 테이블의 id값에 해당하는 내용을 Item 객체의 목록으로 리턴 => 리턴타입이 리스트라서
	// 하지만 우리가 필요한건 한건만 나오면 됨
		return template.selectOne("dao.mapper.ItemMapper.select",param);
		//template로 부터 레코드 한건만 가져오는데 dao.mapper.ItemMapper 가 name space임. 이걸 실행하는데 param 정보를 넣어줄게 . param 에는 id 값 있음.
	}
	public int maxId() {
		//Integer.class : select 결과 자료형
		return template.getMapper(cls).maxId();
	}
	
	public void insert(Item item) {
		template.getMapper(cls).insert(item);
	}
	public void update(Item item) {
		template.getMapper(cls).update(item);
	}
	public void delete(Integer id) {
		param.clear();
		param.put("id",id);
		template.getMapper(cls).delete(param);
	}


}
