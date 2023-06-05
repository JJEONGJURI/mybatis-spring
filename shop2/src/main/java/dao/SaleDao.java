package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;

import dao.mapper.SaleMapper;
import logic.Sale;

@Repository //객체화되고 있어야 shopSerivce 에 주입이 된다.
public class SaleDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<SaleMapper> cls = SaleMapper.class;

	public int getMaxSaleId() { //saleid 최대값 조회
		return template.getMapper(cls).getMaxSaleId();
	}
	public void insert(Sale sale) { //sale 테이블에 데이터 추가
		template.getMapper(cls).insert(sale);
	}
	public List<Sale> list(String userid) {
		param.clear();
		param.put("userid", userid);
		return template.getMapper(cls).select(param);
	//  return template.getMapper(SaleMapper.class).list(userid);
	}
}
