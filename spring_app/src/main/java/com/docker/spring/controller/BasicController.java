package com.docker.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.docker.spring.model.Persons;
import com.docker.spring.service.PersonService;

@RestController
public class BasicController {

	@Autowired
	private PersonService personService;
	
	
	@GetMapping("/all")
	public List<Persons> getAll() {
		
		return personService.findAll();
	}
}