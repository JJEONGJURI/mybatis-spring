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
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>(); //파라미터 전송할 때 쓸거임
	private final Class<ItemMapper> cls = ItemMapper.class;
	public List<Item> list() {
		param.clear();
		return template.getMapper(cls).select(param);		
	}
	public Item getItem(Integer id) {
		param.clear();
		param.put("id", id);
		return template.selectOne("dao.mapper.ItemMapper.select",param);
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
