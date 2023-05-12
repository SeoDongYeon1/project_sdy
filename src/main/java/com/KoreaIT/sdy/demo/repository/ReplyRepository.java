package com.KoreaIT.sdy.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.vo.Reply;

@Mapper
public interface ReplyRepository {

	public void writeReply(String relTypeCode, int relId, String body, int actorId);

	public List<Reply> getForPrintReplies(int relId, String relTypeCode);

}