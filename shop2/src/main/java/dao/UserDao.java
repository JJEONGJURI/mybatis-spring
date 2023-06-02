package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import logic.User;


@Repository
public class UserDao {
	private NamedParameterJdbcTemplate template;
	private RowMapper<User> mapper = new BeanPropertyRowMapper<User>(User.class);
	private Map<String,Object> param = new HashMap<>();
	@Autowired
	public void setDataSource(DataSource dataSource) {
		template = new NamedParameterJdbcTemplate(dataSource);
	}
	public void insert(@Valid User user) { //화면에서 입력받은 정보를 저장하고 있는 user 객체
		SqlParameterSource param = new BeanPropertySqlParameterSource(user);
		//param : user  객체의 프로퍼티를 이용하여 db에 값 등록
		String sql = "insert into useraccount (userid,username,password,"
				+ " birthday,phoneno,postcode,address,email) values " //birthday는 datetime type
				+ " (:userid,:username,:password,"
				+ "  :birthday,:phoneno,:postcode,:address,:email)"; //birthday는 date type
		template.update(sql, param);
				
	}
	public User selectOne(String userid) {
		param.clear();
		param.put("userid", userid);
		return template.queryForObject
				("select * from useraccount where userid=:userid", param, mapper);
		//mapper 에 설정된 유저 프로퍼티와 같은거?
	}
	public User selectOne(String userid, String password) {
		param.clear();
		param.put("userid", userid);
		param.put("password", password);
		return template.queryForObject
				("select * from useraccount where userid=:userid and password=:password", param, mapper);
	}
	public void update(@Valid User user) {
		SqlParameterSource param = new BeanPropertySqlParameterSource(user);
		String sql = 
				"update useraccount set username=:username,birthday=:birthday,phoneno=:phoneno,"
				+ "	postcode=:postcode,address=:address,email=:email"
				+ " where userid=:userid";
		template.update(sql, param);
		
	}
	public void delete(@Valid User user) {
		SqlParameterSource param = new BeanPropertySqlParameterSource(user);
		String sql = 
				"delete from useraccount where userid=:userid";
		template.update(sql,param);
		
	}
	public void delete(String userid) {
		param.clear();
		param.put("userid", userid);
		template.update("delete from useraccount where userid=:userid", param);

	}
	public void update(String userid, String chgpass) {
		param.clear();
		param.put("userid", userid);
		param.put("password", chgpass);
		template.update("update useraccount set password=:password where userid=:userid",param);
		
	}
	public List<User> list() {
		return template.query("select * from useraccount" , param, mapper);
		//유저클래스에 있는 프로퍼티와 유저어카운트에 있는 프로퍼티와 이름이 같으면 매핑시켜서 유저객체로 리텅해줘라?
	}
	
	// select * from useraccount where userid in('admin','test1')
	public List<User> list(String[] idchks) {
		StringBuilder ids = new StringBuilder();
		for(int i=0; i<idchks.length; i++) {
			ids.append("'").append(idchks[i]).append((i==idchks.length-1)?"'":"',");
		}
		/*
		 * mapper : select 구문의 실행 결과
		 * 	mapper = new BeanPropertyRowMapper<User>(User.class);
		 * 	1.User 객체 생성
		 * 	2.user.setUserid(userid 컬럼값)
		 * 		....
		 */
		String sql = "select * from useraccount where userid in (" + ids.toString() + ")";
		return template.query(sql,mapper);
	}


	public String search(User user) {
		String col = "userid";
		if(user.getUserid() != null) col = "password";
		String sql = "select "  + col + " from useraccount "
				+ " where email=:email and phoneno=:phoneno";
		if(user.getUserid() != null) {
			sql += " and userid=:userid";
		}
		/*
		 * BeanPropertySqlParameterSource(user) : user 객체의 프로퍼티로 파라미터를 설정
		 * 							:email : user.getEmail() <= 프로퍼티
		 * 							:phoneno : user.getPhoneno()
		 * String.class : select 구문의 결과의 자료형
		 */
		SqlParameterSource param = 
				new BeanPropertySqlParameterSource(user);
		return template.queryForObject(sql, param, String.class);
	}


}

