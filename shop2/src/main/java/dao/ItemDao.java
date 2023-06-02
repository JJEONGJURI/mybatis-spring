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
		return template.selectOne("dao.Mapper.ItemMapper.select",param);
	}
	public int maxId() {
		//Integer.class : select 결과 자료형
		return template.queryForObject
				("select ifnull(max(id),0) from item", param , Integer.class);
	}
	
	public void insert(Item item) {
		//:id ...  : item 객체의 프로퍼티로 설정
		SqlParameterSource param = new BeanPropertySqlParameterSource(item);
		String sql = 
				"insert into item (id,name,price,description, pictureUrl)"
				+ " values (:id,:name,:price,:description,:pictureUrl)";
		template.update(sql, param);
	}
	public void update(Item item) {
		SqlParameterSource param = new BeanPropertySqlParameterSource(item);
		String sql = 
				"update item set name=:name, price=:price, description=:description,  pictureUrl=:pictureUrl"
				+ " where id=:id";
		
		template.update(sql, param);
	}
	public void delete(Integer id) {
		param.clear();
		param.put("id",id);
		template.update("delete from item where id=:id", param);
	}


}
