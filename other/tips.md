## 1.EXE依赖查询  
dumpbin.exe /dependents .\xxx.exe


## compile_commands.json导出：
Cmake ：
`set(EXPORT_COMPILE_COMMANDS ON)`



double[] xs = {1，1.5，2，3，3.5，4，5.5，6，6.5，7 };
double[] ys = {20，11,3，35，13，4，46，39,14，51};
var interpl = Interpolate.CubicSpline(xs，ys);
List<double[] pointsSmooth = new List<double[]>();
int countSmooth =100;
double stepSmooth =(xs.Last()- xs.First())/ countSmooth;
for (int i = 0; i< countSmooth;i++){
    double xt = xs[0] +i * stepSmooth;
    double yt = interp.Interpolate(xt);
    pointsSmooth.Add(new double[] {xt, yt});
}

while(true){
    ChangeObjectThread thd1=new ChangeObjectThread();
    thd1.start();
    Thread.sleep(150);
    thd1.stopMe();
}

	int eventID;     //事件id 每次事件结束 +1
	std::string UID;
	std::string startTime;//起始时间
	std::string finishTime;//结束时间
	std::string RootPath;//根路径
	std::string RecName;//录制文件名
	std::string P_RecorderFile;//报警录像（绝对路径）
	std::string P_RelateFile;//报警录像（相对路径）	

	boost::uuids::uuid uid = boost::uuids::random_generator()();
	UID = boost::uuids::to_string(uid);

int EventHanlde::RecInit(int CameraID, std::string URL, std::string videoStartTime, int type)
{
	std::string RecDir = RootPath + Cyc::getdate();
	std::string m_date = Cyc::getdate();

	startTime = videoStartTime;

	if (!std::filesystem::exists(RecDir)) {
		//不存在，新建路径
		hdLogger->info("file path note exists,create new~");
		std::filesystem::create_directories(RecDir);
	}
	//生成文件名
	if (type == 1) {
		RecName = std::string("Fire") + std::to_string(CameraID) + std::string("_") + startTime + std::string(".mp4");
		P_RecorderFile = RecDir + std::string("/") + RecName;
		P_RelateFile = "http://" + URL + std::string("/") + m_date + std::string("/") + RecName;
	}
	else if (type == 2) {
		RecName = std::string("Cloth") + std::to_string(CameraID) + std::string("_") + startTime + std::string(".vob");
		P_RecorderFile = RecDir + std::string("/") + RecName;
		P_RelateFile = "http://" + URL + std::string("/") + m_date + std::string("/") + RecName;
	}

	//初始化临时录像
	/*TempRec.open(P_RecorderFile, std::ios::out | std::ios::app | std::ios::binary);
	if (!TempRec.is_open()) {
		std::cout << "failed to open file" << P_RecorderFile << std::endl;
		return -1;
	}*/	
	return 0;
}

bool EventHanlde::RecOpen(int codec, double fps, cv::Size sz)
{
	bool ret = false;
	if (P_RecorderFile.empty()) {
		hdLogger->error("empty path please call RecInit() first!");
		return ret;
	}
	try
	{
		//int codec = cv::VideoWriter::fourcc('M', 'J', 'P', 'G');
		ret = wt.open(P_RecorderFile, codec, fps, sz);

		// check if we succeeded
		if (!wt.isOpened()) {
			hdLogger->error("Could not open the output video file for write");
		}
	}
	catch (const std::exception& e)
	{
		hdLogger->error(e.what());
	}
	
	return ret;
}

int EventHanlde::RecWrite(cv::Mat& img)
{
	wt.write(img);
	return 0;
}

int EventHanlde::RecClose()
{
	wt.release();
	return 0;
}