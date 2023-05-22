package com.KoreaIT.sdy.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.repository.BoardRepository;
import com.KoreaIT.sdy.demo.vo.Board;

@Service
public class BoardService {
	@Autowired
	private BoardRepository boardRepository;
	
	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}

	// id에 해당하는 게시판 가져오기
	public Board getBoardById(int id) {
		return boardRepository.getBoardById(id);
	}
}
