
class Review {
  final String compName;
  final String revCompType;
  final String revUsername;
  final String revCompUid;
  final String revDate;
  final String revFlag;
  final String revFromId;
  final String revId;
  final String revText;
  final String revTypeTitle;
  final double revTrustRating;
  final double revResultRating;
  final double revAvailabilityRating;
  final double revAgScore;
  final String reviewAnswer;
  final bool hasAnswer;
  final String revResponseDate;

  Review(
      {this.compName,
        this.revCompType,
        this.revUsername,
        this.revCompUid,
        this.revDate,
        this.revFlag,
        this.revFromId,
        this.revId,
        this.revText,
        this.revTypeTitle,
        this.revTrustRating,
        this.revResultRating,
        this.revAvailabilityRating,
        this.revAgScore,
      this.reviewAnswer,
      this.hasAnswer,
      this.revResponseDate});


  Review.fromJson(Map<String, dynamic> parsedJSON)
      : compName = parsedJSON['Rev_comp_name'] ?? '',
        revCompType = parsedJSON['Rev_comp_type'] ?? '',
        revUsername = parsedJSON['Rev_username'] ?? '',
        revTypeTitle = parsedJSON['Rev_type_title'] ?? '',
        revCompUid = parsedJSON['Rev_comp_uid'] ?? '',
        revDate = parsedJSON['Rev_date'] ?? '',
        revFlag = parsedJSON['Rev_flag'] ?? '',
        revFromId = parsedJSON['Rev_from_id'] ?? '',
        revId = parsedJSON['Rev_id'] ?? '',
        revText = parsedJSON['Rev_text'] ?? '',
        revTrustRating = parsedJSON['Rev_trust_rating'].toDouble() ?? 0.0,
        revResultRating = parsedJSON['Rev_result_rating'].toDouble() ?? 0,
        revAvailabilityRating = parsedJSON['Rev_availability_rating'].toDouble() ?? 0.0,
        revAgScore = parsedJSON['Rev_ag_score'].toDouble() ?? 0.0,
        reviewAnswer = parsedJSON['Rev_answer'] == null? '' : parsedJSON['Rev_answer'],
        hasAnswer = parsedJSON['Rev_has_answer'] == null?  false : parsedJSON['Rev_has_answer'],
        revResponseDate = parsedJSON['Rev_response_date'] == null? '' : parsedJSON['Rev_response_date'];

}
