@interface UIDateLabel : UILabel
@property (nonatomic, strong) NSDate *date;
@end

@interface MPRecentsTableViewCell
@property (nonatomic, strong) UIDateLabel *callerDateLabel;
@end

static bool is24h;


%hook MPRecentsTableViewCell
-(void)layoutSubviews{
	%orig;
	if(![self.callerDateLabel.text containsString:@":"]){
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	if(is24h){
		[dateFormatter setDateFormat:@"\nHH:mm"];
	}else{
		[dateFormatter setDateFormat:@"\nh:mm a"];
	}
	
	self.callerDateLabel.textAlignment = 2;
	self.callerDateLabel.numberOfLines = 2;
	self.callerDateLabel.text = [self.callerDateLabel.text stringByAppendingString:[dateFormatter stringFromDate:self.callerDateLabel.date]];
	}

}
%end

%ctor{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setLocale:[NSLocale currentLocale]];
	[formatter setDateStyle:NSDateFormatterNoStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	NSString *dateString = [formatter stringFromDate:[NSDate date]];
	NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
	NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
	is24h = (amRange.location == NSNotFound && pmRange.location == NSNotFound);
}