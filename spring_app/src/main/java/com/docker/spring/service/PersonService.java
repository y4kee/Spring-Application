package com.docker.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docker.spring.model.Persons;
import com.docker.spring.repository.PersonRepository;

@Service
public class PersonService {

	
	@Autowired
	private PersonRepository personRepository;
	
	
	public List<Persons> findAll(){
		return personRepository.findAll();
	}


    public Object findById(Long id) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'findById'");
    }
	
}