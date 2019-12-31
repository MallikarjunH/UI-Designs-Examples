//
//  BabyBumbTrackerDetailsVC.swift
//  VidalHealth
//
//  Created by mallikarjun on 04/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Alamofire
import Photos

class BabyBumbTrackerDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,selectedPhotoOptionPopUpVCDelegate {
    
    var popUpViewController: STPopupController!
    var simpleImagePicker: UIImagePickerController? = nil
    var selectedImage:UIImage? = nil
    var monthValue = ""
    var imageData1:NSData?
    var attachmentFileName = ""
    var mimeType = "image/jpg"
    var patientSlug = ""
    
    // let title1Array = ["",""]
    // var paramTOAdd:[String:Any] = ["patient_slug":"","upload_type":"baby_bump_tracker","fileData":"","month":""]
    
    
    @IBOutlet weak var navigatiionBarMonthTitleLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        mainTableView.register(UINib(nibName: "DetailsXib", bundle: nil), forCellReuseIdentifier: "BabyBumbTrackerDetailsCell2Id")
        
        navigatiionBarMonthTitleLabel.text = GlobalVariables.sharedManager.babyMonth
        
       // selectedImage = nil
    }
    
    //MARK: TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BabyBumbTrackerDetailsCell1Id", for: indexPath) as! BabyBumbTrackerDetailsCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            cell.monthLabel.text = GlobalVariables.sharedManager.babyMonth
            
            if selectedImage != nil{
                
                cell.sampleFrontImage.isHidden = true
                cell.mainBackgroundImage.isHidden = false
                cell.mainBackgroundImage.image = self.selectedImage
                // print("selectedImage is not nil")
            }
            else{
                if  GlobalVariables.sharedManager.babyImgUrl != nil &&  GlobalVariables.sharedManager.babyImgUrl != ""{
                    cell.sampleFrontImage.isHidden = true
                    cell.mainBackgroundImage.isHidden = false
                    
                  /*  getDataFromImage(from: GlobalVariables.sharedManager.babyImgUrl!) { data, response, error in
                        guard let data = data, error == nil else { return }
                        
                        image = UIImage(data: imageData as Data)
                    }
                    
                    DispatchQueue.main.async() {
                        
                    } */
                    
                    var image:UIImage? = nil
                    
                    let imageUrl:NSURL = NSURL(string: GlobalVariables.sharedManager.babyImgUrl!)!
                    if let imageData:NSData = NSData(contentsOf: imageUrl as URL){
                        
                        image = UIImage(data: imageData as Data)
                    }
                
                     DispatchQueue.main.async() {
                        
                        cell.mainBackgroundImage.image = image
                     }
                    
                    // print("GlobalVariables.sharedManager.babyImgUrl is not nil")
                }else{
                    cell.mainBackgroundImage.isHidden = true
                    cell.sampleFrontImage.isHidden = false
                    cell.sampleFrontImage.image = UIImage(named: GlobalVariables.sharedManager.babyMonthImg ?? "month1")
                    // print("GlobalVariables.sharedManager.babyImgUrl is nil")
                }
            }
            
            cell.selectPhotoButton.addTarget(self, action: #selector(selectPhotoOptionPopUp(sender:)), for: .touchUpInside)
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BabyBumbTrackerDetailsCell2Id", for: indexPath) as! BabyBumbTrackerDetailsCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.babyMonth == "1st Month"{
                
                // title 1
                cell.title1.text = "Baby"
                cell.title1Description.text = "Your baby is still just a glimmer in your eye. It’s difficult to know exactly when conception occurred, so doctors calculate your due date from the beginning of your last menstrual cycle. By the end of month 1, your egg is fertilized and burrows into the lining of your uterus. This is called implantation."
                cell.title1Description.lineBreakMode = .byWordWrapping
                
                // title 2
                cell.title2.text = "Mom-to-be"
                cell.title2Description.text = "You're probably expecting your period this week, and if it doesn't occur, it might be one of the first signs that you're pregnant. You may also notice light spotting as the embryo implants itself in your uterus. You might not feel any different yet, but the amniotic cavity, which will be filled with fluid, and the placenta, which will bring oxygen and nutrients to nourish your baby, are forming in your uterus."
                cell.title2Description.lineBreakMode = .byWordWrapping
                
                // title 3
                cell.title3.text = ""
                
                cell.title3SubTitle1.text = ""
                cell.title3SubTitle1Description.text = ""
                
                cell.title3SubTitle2.text = ""
                cell.title3SubTitle2Description.text = ""
                
                cell.title3SubTitle3.text = ""
                cell.title3SubTitle3Description.text = ""
                
                // title 4
                cell.title4.text = ""
                cell.title4Description.text = ""
                
                //title 5
                cell.title5.text = ""
                cell.title5Description.text = ""
                
                //title 5
                cell.title6.text = ""
                
                cell.title6SubTitle1.text = ""
                cell.title6SubTitle1Description.text = ""
                
                cell.title6SubTitle2.text = ""
                cell.title6SubTitle2Description.text = ""
                
                cell.title6SubTitle3.text = ""
                cell.title6SubTitle3Description.text = ""
                
                monthValue = "1"
            }
            else if GlobalVariables.sharedManager.babyMonth == "2nd Month"{
                
                // title 1
                cell.title1.text = "Baby"
                cell.title1Description.text = "Your little one now has facial features such as the mouth, tongue, and nose. Eyelids are developed but won’t open for several months. Ears are just budding now, but they will grow into more prominent shape. Fingers, toes and toenails will grow shortly. The organs, skeleton, and limbs will be in place by the end of this month. The placenta will be in place. Small movements may be present by now though you won’t be able to feel them."
                cell.title1Description.lineBreakMode = .byWordWrapping
                
                // title 2
                cell.title2.text = "Mom-to-be"
                cell.title2Description.text = "Though there won’t be any visible changes in your body, your breasts may start to feel heavier and look fuller. Due to hormonal changes and increased blood volume, some expecting women may develop red- and purple-coloured varicose veins."
                cell.title2Description.lineBreakMode = .byWordWrapping
                
                // title 3
                cell.title3.text = "Pregnancy Quick List for the Month"
                
                cell.title3SubTitle1.text = "Doctor’s appointments:"
                cell.title3SubTitle1Description.text = "Keep all of your prenatal appointments to make sure you’re staying healthy and progressing well. Often at the first appointment, you will be able to hear the fetal heartbeat."
                cell.title3SubTitle1Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle2.text = "Follow a healthy diet:"
                cell.title3SubTitle2Description.text = "Take your nutritionist’s advice and follow a nutritious and healthy pregnancy diet."
                cell.title3SubTitle2Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle3.text = "Emotions:"
                cell.title3SubTitle3Description.text = "You might be on an emotional roller-coaster. This is due to the hormonal changes and is very natural. Speak to your dear ones or seek out a support group to manage emotional surges."
                cell.title3SubTitle3Description.lineBreakMode = .byWordWrapping
                
                // title 4
                cell.title4.text = ""
                cell.title4Description.text = ""
                
                //title 5
                cell.title5.text = ""
                cell.title5Description.text = ""
                
                //title 5
                cell.title6.text = ""
                
                cell.title6SubTitle1.text = ""
                cell.title6SubTitle1Description.text = ""
                
                cell.title6SubTitle2.text = ""
                cell.title6SubTitle2Description.text = ""
                
                cell.title6SubTitle3.text = ""
                cell.title6SubTitle3Description.text = ""
                
                monthValue = "2"
            }
            else if GlobalVariables.sharedManager.babyMonth == "3rd Month"{
                
                // title 1
                cell.title1.text = "Baby"
                cell.title1Description.text = "The genitals will start forming in the third month. The foetus starts to learn to swallow and suck. Little one’s sensory development continues. One marked development is that the little one is now able to hear muffled sounds from the outside world– such as the sound of your voice and your heartbeat, and the eyes can move."
                cell.title1Description.lineBreakMode = .byWordWrapping
                
                // title 2
                cell.title2.text = "Mom-to-be"
                cell.title2Description.text = "Your baby bump may begin to show up by now. Your breast may feel fuller. Nausea and morning sickness might have subsided, and those bouts of nausea are replaced by hunger. You may experience skin pigment changes such as a dark line on the abdomen, or dark patches on the face."
                cell.title2Description.lineBreakMode = .byWordWrapping
                
                // title 3
                cell.title3.text = "Pregnancy Quick List for the Month"
                
                cell.title3SubTitle1.text = "Pregnancy exercise:"
                cell.title3SubTitle1Description.text = "You may experience an energy boost with the subsiding of the disturbing morning sickness. So, this is a great time to get moving. Speak to your doctor and learn about some gentle exercise options that are suitable for you. Exercises like prenatal yoga and swimming are usually safe and suitable for pregnancy. While talking to your gynaecologist, don’t forget to mention if you have any medical condition that should be considered while doing exercise."
                cell.title3SubTitle1Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle2.text = "Bond with your bump:"
                cell.title3SubTitle2Description.text = "As your little one can hear muffled sounds as mentioned above, talking to and singing to your ‘bump’ will help you bond with the little one. You may also listen to your favourite music using speakers; not earphones."
                cell.title3SubTitle2Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle3.text = ""
                cell.title3SubTitle3Description.text = ""
                
                // title 4
                cell.title4.text = ""
                cell.title4Description.text = ""
                
                //title 5
                cell.title5.text = ""
                cell.title5Description.text = ""
                
                //title 5
                cell.title6.text = ""
                
                cell.title6SubTitle1.text = ""
                cell.title6SubTitle1Description.text = ""
                
                cell.title6SubTitle2.text = ""
                cell.title6SubTitle2Description.text = ""
                
                cell.title6SubTitle3.text = ""
                cell.title6SubTitle3Description.text = ""
                
                monthValue = "3"
            }
            else if GlobalVariables.sharedManager.babyMonth == "4th Month"{
                
                // title 1
                cell.title1.text = "Baby"
                cell.title1Description.text = "Though still tiny, your baby has already started developing all kinds of features – even eyebrows and eyelashes. The foetus may soon start to grow a crop of hair on his head. The body of your little one is covered with a waxy coating called vernix, and it has a fine hair called lanugo all over the body. Baby might have already learned to suck, so it should be sucking its thumb."
                cell.title1Description.lineBreakMode = .byWordWrapping
                
                // title 2
                cell.title2.text = "Mom-to-be"
                cell.title2Description.text = "This month could be quite exciting as you may sense your baby moving for the first time. The sensation could be like bubbles popping inside your tummy or like butterflies fluttering. So, pay attention to your body and enjoy the feeling. It could take 18-20 weeks to experience the movement if it is your first pregnancy. You may notice that people are curious to know if you are pregnant – it's because your baby bump is a little more obvious by now. You may also notice that the dark line is becoming more obvious. Don’t worry, it is because of the hormonal changes your body is experiencing now. It will fade away by a few months after delivery."
                cell.title2Description.lineBreakMode = .byWordWrapping
                
                // title 3
                cell.title3.text = "Pregnancy Quick List for the Month"
                
                cell.title3SubTitle1.text = "Start shopping for maternity wear:"
                cell.title3SubTitle1Description.text = "It could be a little difficult to put on pants and pyjamas because of the growing tummy. It’s time to start shopping for comfortable maternity wear that gives your growing body plenty of room to move and breathe and buy good maternity bras to support your growing breasts."
                cell.title3SubTitle1Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle2.text = "Handle hunger pangs:"
                cell.title3SubTitle2Description.text = "You may have intense hunger pangs by this time. There are chances that you end up in binge eating. So be prepared for it with healthy snacks, fruit bowls or salads. Follow your doctor’s diet recommendations."
                cell.title3SubTitle2Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle3.text = ""
                cell.title3SubTitle3Description.text = ""
                
                // title 4
                cell.title4.text = "Foetal Development"
                cell.title4Description.text = "Your baby has now started to put on weight. You might feel some jerking inside your tummy - probably your baby has started hiccupping. Your baby is now able to move arms and can open and close his hands. Myelin sheath, a fatty coating that helps carry messages from the nerves in the body to the brain, starts developing this month."
                cell.title4Description.lineBreakMode = .byWordWrapping
                
                //title 5
                cell.title5.text = "Changes to Your Body"
                cell.title5Description.text = "You might have noticed the ‘pregnancy glow’ on your face. Your belly continues to grow, and this might cause your belly button to poke out. There could be some changes in the texture and growth of your nails as well. First-time mothers might be experiencing the movements for the first time around this month."
                cell.title5Description.lineBreakMode = .byWordWrapping
                
                //title 6
                cell.title6.text = "Pregnancy Quick List for the Month"
                
                cell.title6SubTitle1.text = "Sign up for prenatal classes:"
                cell.title6SubTitle1Description.text = "It’s time to get enrolled in a prenatal class. It is the best way to get support and information."
                cell.title6SubTitle1Description.lineBreakMode = .byWordWrapping
                
                cell.title6SubTitle2.text = "Know the signs of premature labour:"
                cell.title6SubTitle2Description.text = "You should be aware of the signs of premature labour by now. Talk to your doctor about this and in case you feel or see anything unusual, contact your doctor immediately."
                cell.title6SubTitle2Description.lineBreakMode = .byWordWrapping
                
                cell.title6SubTitle3.text = "Get comfortable:"
                cell.title6SubTitle3Description.text = "The growing bump makes it very difficult to get a comfortable position to sleep. Try different poses and use pregnancy pillows for a good night’s sleep. It is important that you sleep for about 8 hours. Also, choose more comfortable shoes if you are experiencing swollen feet."
                cell.title6SubTitle3Description.lineBreakMode = .byWordWrapping
                
                monthValue = "4"
            }
            else if GlobalVariables.sharedManager.babyMonth == "5th Month"{
                
                // title 1
                cell.title1.text = "Baby"
                cell.title1Description.text = "Your baby has now started to put on weight. You might feel some jerking inside your tummy - probably your baby has started hiccupping. Your baby is now able to move arms and can open and close his hands. Myelin sheath, a fatty coating that helps carry messages from the nerves in the body to the brain, starts developing this month."
                cell.title1Description.lineBreakMode = .byWordWrapping
                
                // title 2
                cell.title2.text = "Mom-to-be "
                cell.title2Description.text = "You might have noticed the ‘pregnancy glow’ on your face. Your belly continues to grow, and this might cause your belly button to poke out. There could be some changes in the texture and growth of your nails as well. First-time mothers might be experiencing the movements for the first time around this month."
                cell.title2Description.lineBreakMode = .byWordWrapping
                
                // title 3
                cell.title3.text = "Pregnancy Quick List for the Month"
                
                cell.title3SubTitle1.text = "Sign up for prenatal classes:"
                cell.title3SubTitle1Description.text = "It’s time to get enrolled in a prenatal class. It is the best way to get support and information."
                cell.title3SubTitle1Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle2.text = "Know the signs of premature labour:"
                cell.title3SubTitle2Description.text = "You should be aware of the signs of premature labour by now. Talk to your doctor about this and in case you feel or see anything unusual, contact your doctor immediately."
                cell.title3SubTitle2Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle3.text = "Get comfortable:"
                cell.title3SubTitle3Description.text = "The growing bump makes it very difficult to get a comfortable position to sleep. Try different poses and use pregnancy pillows for a good night’s sleep. It is important that you sleep for about 8 hours. Also, choose more comfortable shoes if you are experiencing swollen feet."
                cell.title3SubTitle3Description.lineBreakMode = .byWordWrapping
                
                // title 4
                cell.title4.text = ""
                cell.title4Description.text = ""
                
                //title 5
                cell.title5.text = ""
                cell.title5Description.text = ""
                
                //title 5
                cell.title6.text = ""
                
                cell.title6SubTitle1.text = ""
                cell.title6SubTitle1Description.text = ""
                
                cell.title6SubTitle2.text = ""
                cell.title6SubTitle2Description.text = ""
                
                cell.title6SubTitle3.text = ""
                cell.title6SubTitle3Description.text = ""
                
                monthValue = "5"
            }
            else if GlobalVariables.sharedManager.babyMonth == "6th Month"{
                
                // title 1
                cell.title1.text = "Baby"
                cell.title1Description.text = "This month, your baby’s eyelids will open, and he will start responding to loud noises. Your baby’s taste buds have developed and you will be surprised to know that the baby can taste the different flavours through the amniotic fluid."
                cell.title1Description.lineBreakMode = .byWordWrapping
                
                // title 2
                cell.title2.text = "Mom-to-be"
                cell.title2Description.text = "You are 6 months pregnant now, which means you are at the end of the second trimester. You might have gained quite a bit of weight by now. Spending long periods on your feet may become more uncomfortable as the weight increases. So put your feet up whenever you can. Your skin starts to stretch, and this could cause itching. Apply plenty of moisturizers to reduce itching. You might need many pillows to sleep comfortably. Pregnancy pillows are available, try using one to sleep comfortably. Swelling may occur on your feet, ankles, hands, and face – call your doctor immediately if the swelling is sudden or severe."
                cell.title2Description.lineBreakMode = .byWordWrapping
                
                // title 3
                cell.title3.text = "Pregnancy Quick List for the Month"
                
                cell.title3SubTitle1.text = "Read up on childbirth:"
                cell.title3SubTitle1Description.text = "You might have already attended prenatal class, even after that you may still have questions or concerns. Utilize your free time to read about childbirth. Alternatively, you may speak to mums about their experiences."
                cell.title3SubTitle1Description.lineBreakMode = .byWordWrapping
                
                
                cell.title3SubTitle2.text = "Relax as much as you can:"
                cell.title3SubTitle2Description.text = "You need plenty of rest. Although you might feel energetic and you have much to organize, you should find time to rest and relax."
                cell.title3SubTitle2Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle3.text = "Drink plenty of watee:"
                cell.title3SubTitle3Description.text = "Make sure that you drink 2-3 litres of water. This prevents you from having common pregnancy problems such as constipation, haemorrhoids, and bladder infections. Dehydration can cause contractions, and this could trigger preterm labour. If you find it difficult to drink this much water, try sipping water throughout the day. Also, try adding lime to the water if you don't like the taste of water."
                cell.title3SubTitle3Description.lineBreakMode = .byWordWrapping
                
                // title 4
                cell.title4.text = ""
                cell.title4Description.text = ""
                
                //title 5
                cell.title5.text = ""
                cell.title5Description.text = ""
                
                //title 5
                cell.title6.text = ""
                
                cell.title6SubTitle1.text = ""
                cell.title6SubTitle1Description.text = ""
                
                cell.title6SubTitle2.text = ""
                cell.title6SubTitle2Description.text = ""
                
                cell.title6SubTitle3.text = ""
                cell.title6SubTitle3Description.text = ""
                
                monthValue = "6"
            }
            else if GlobalVariables.sharedManager.babyMonth == "7th Month"{
                
                // title 1
                cell.title1.text = "Baby"
                cell.title1Description.text = "Hurray!! You have entered the final trimester of your pregnancy. Babies often turn head-down just after 33 weeks. This is in preparation for birth and the baby might also start to move downward, putting more pressure on your bladder. The pressure you felt on the lungs may ease, making it a little easier to breathe. Your baby’s bones will soon start to harden. However, the skull remains soft to make it easy for the baby to pass through the birth canal."
                cell.title1Description.lineBreakMode = .byWordWrapping
                
                
                // title 2
                cell.title2.text = "Mom-to-be"
                cell.title2Description.text = "As the baby grows and occupies most of the uterus, the space in your uterus is getting reduced. The baby movements might have reduced because of this. Do not walk fats or stand up suddenly, because the centre of gravity changes as your tummy grows, and it could make you feel unsteady on your feet and you might lose balance if you move fast. Naturally, you might become unable to bend over because of the big tummy. You might have noticed that your breasts have become heavier than before. Don’t worry if you notice that the veins on your breasts are more visible, or the colour of your nipples darken – that’s quite normal."
                cell.title2Description.lineBreakMode = .byWordWrapping
                
                // title 3
                cell.title3.text = "Pregnancy Quick List for the Month"
                
                cell.title3SubTitle1.text = "Find out about preterm labour:"
                cell.title3SubTitle1Description.text = "Learning about the signs of pre-term labour may alleviate unwanted fear. Persistent cramps or contractions, spotting or bleeding, and lower back pain should be taken seriously. Do not hesitate to consult your doctor if you find/feel anything unusual."
                cell.title3SubTitle1Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle2.text = "Learn about Braxton Hicks contractions:"
                cell.title3SubTitle2Description.text = "Your uterus may do some practice contractions - \"false\" contractions – which you might experience several times during your third trimester. These are known as Braxton Hicks contractions. Try to learn more about these contractions and understand how are they different from real contractions."
                cell.title3SubTitle2Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle3.text = ""
                cell.title3SubTitle3Description.text = ""
                
                // title 4
                cell.title4.text = ""
                cell.title4Description.text = ""
                
                //title 5
                cell.title5.text = ""
                cell.title5Description.text = ""
                
                //title 5
                cell.title6.text = ""
                
                cell.title6SubTitle1.text = ""
                cell.title6SubTitle1Description.text = ""
                
                cell.title6SubTitle2.text = ""
                cell.title6SubTitle2Description.text = ""
                
                cell.title6SubTitle3.text = ""
                cell.title6SubTitle3Description.text = ""
                
                monthValue = "7"
            }
            else if GlobalVariables.sharedManager.babyMonth == "8th Month"{
                
                // title 1
                cell.title1.text = "Baby"
                cell.title1Description.text = "At 8 months your baby’s development is almost complete and it is time that the little one put on weight rapidly. You might notice that the baby has ‘dropped’ (moving down toward your pelvis)."
                cell.title1Description.lineBreakMode = .byWordWrapping
                
                // title 2
                cell.title2.text = "Mom-to-be"
                cell.title2Description.text = "It’s the eighth month! You can expect to go into labour at any time from the end of this month. From eighth month onwards, you may experience more emotional changes than physical changes. You may be overwhelmed by the advises, do and don’ts and many more. It could even make you anxious, annoyed, or nervous. You now know that you are going to meet the baby soon- and this could create a mixed feeling of joy and anxiety. You need to settle into these feelings"
                cell.title2Description.lineBreakMode = .byWordWrapping
                
                // title 3
                cell.title3.text = "Pregnancy Quick List for the Month"
                
                cell.title3SubTitle1.text = "Take some healthy steps"
                cell.title3SubTitle1Description.text = "You should start doing Kegel exercises and breathing exercises now. Also, practice good posture and keep yourself well hydrated."
                cell.title3SubTitle1Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle2.text = "Pack your hospital bag"
                cell.title3SubTitle2Description.text = "You should be hospital ready as you can expect to go into labour any time after the eighth month. From your medical records to dress and toiletries, your hospital bag should include everything you will need during labour and delivery and your hospital stay. It should also include the dress, wet tissues, wrapping clothes, diapers and other things the little one will need at the hospital and on the way home. Prepare a list and get started!"
                cell.title3SubTitle2Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle3.text = ""
                cell.title3SubTitle3Description.text = ""
                
                // title 4
                cell.title4.text = ""
                cell.title4Description.text = ""
                
                //title 5
                cell.title5.text = ""
                cell.title5Description.text = ""
                
                //title 5
                cell.title6.text = ""
                
                cell.title6SubTitle1.text = ""
                cell.title6SubTitle1Description.text = ""
                
                cell.title6SubTitle2.text = ""
                cell.title6SubTitle2Description.text = ""
                
                cell.title6SubTitle3.text = ""
                cell.title6SubTitle3Description.text = ""
                
                monthValue = "8"
            }
            else if GlobalVariables.sharedManager.babyMonth == "9th Month"{
                
                // title 1
                cell.title1.text = "Baby"
                cell.title1Description.text = "Your baby is now ready to enter this world. However, she will continue to gain weight until she’s born. The baby might have already dropped down into the pelvis, head down."
                cell.title1Description.lineBreakMode = .byWordWrapping
                
                // title 2
                cell.title2.text = "Mom-to-be"
                cell.title2Description.text = "You will be feeling tired, and impatient; sitting or lying down may become even more uncomfortable. You may experience contractions as the body prepares for the labour. Because of the pressure on the bladder, you might have to visit the toilet many times a day, which could be annoying."
                cell.title2Description.lineBreakMode = .byWordWrapping
                
                // title 3
                cell.title3.text = "Pregnancy Quick List for the Month"
                
                cell.title3SubTitle1.text = "Plan hospital visits and the birth announcement:"
                cell.title3SubTitle1Description.text = " Your doctor might have indicated about your admission day – get ready with you documents and hospital essentials. This is very important as you will have to rush to the hospital if the contraction starts while you’re at home. Think about how you will announce the birth to friends and family if you want to do it in a special way."
                cell.title3SubTitle1Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle2.text = "Find the right baby name:"
                cell.title3SubTitle2Description.text = "Get ready with a baby boy and a baby girl name. If you already have favourite names, kudos to you!"
                cell.title3SubTitle2Description.lineBreakMode = .byWordWrapping
                
                cell.title3SubTitle3.text = "Get some sleep:"
                cell.title3SubTitle3Description.text = "Get as much sleep as you can. Enjoy these last few ‘baby-free’ days -you’re going to be super busy for some years! "
                cell.title3SubTitle3Description.lineBreakMode = .byWordWrapping
                
                // title 4
                cell.title4.text = ""
                cell.title4Description.text = ""
                
                //title 5
                cell.title5.text = ""
                cell.title5Description.text = ""
                
                //title 5
                cell.title6.text = ""
                
                cell.title6SubTitle1.text = ""
                cell.title6SubTitle1Description.text = ""
                
                cell.title6SubTitle2.text = ""
                cell.title6SubTitle2Description.text = ""
                
                cell.title6SubTitle3.text = ""
                cell.title6SubTitle3Description.text = ""
                
                monthValue = "9"
            }
            else {}
            
            
            
            return cell
            
        }
    }
    
    //MARK: ImagePicker PopUp View
    @objc func selectPhotoOptionPopUp(sender:UIButton){
        
        self.showSelectPhotoPopUp()
    }
    
    
    func showSelectPhotoPopUp() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp(_:)))
        let storyBoard = UIStoryboard.init(name: "HealthTools", bundle: nil)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: "PhotoPickerPopUpVCId") as! PhotoPickerPopUpVC
        popUpVC.suggistionPopUpDelegate = self as selectedPhotoOptionPopUpVCDelegate
        // popUpVC.heightValueArray = dropDownData
        
        popUpViewController = STPopupController.init(rootViewController: popUpVC)
        popUpViewController.backgroundView?.addGestureRecognizer(gestureRecognizer)
        popUpViewController.navigationBarHidden = true
        popUpViewController.transitionStyle = STPopupTransitionStyle.fade
        DispatchQueue.main.async(execute: {
            self.popUpViewController.present(in: AppDelegate.topMostController())
        })
    }
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer) {
        popUpViewController.dismiss()
    }
    
    func selectPhotoPopUpSelected(_ selectedOption: String) {
        
        // print(selectedOption)
        
        popUpViewController.dismiss()
        
        if selectedOption == "gallery"{
            
            self.simpleImagePicker = UIImagePickerController()
            self.simpleImagePicker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.simpleImagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.simpleImagePicker?.allowsEditing = true
            self.present(self.simpleImagePicker!, animated: true, completion: nil)
        }
        else if  selectedOption == "camera"{
            
            self.simpleImagePicker = UIImagePickerController()
            self.simpleImagePicker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.simpleImagePicker!.sourceType = UIImagePickerController.SourceType.camera
            self.simpleImagePicker?.allowsEditing = true
            self.present(self.simpleImagePicker!, animated: true, completion: nil)
        }
        
    }
    
    // This Code for Swift 4.0 and below versions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            selectedImage = editedImage
            
        } else if let originalimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            selectedImage = originalimage
        }
        
        //get image informarions
        let imgData = UIImageJPEGRepresentation(selectedImage!, 0.5)
        // let imgDataInData: NSData  =  NSData(data: imgData!) //not required for image
        
        imageData1 = imgData as NSData?
        //  let fileSize:Double =  Double(imgDataInData.length) / 1024.0 //image size in kb
        
        var fileName : String!
        
        if let imgFileName = info[UIImagePickerControllerReferenceURL]
        {
            let url = imgFileName as? URL ?? URL(string: "")!
            //let ext = url.absoluteString.components(separatedBy: "ext=")[1]
            // print("File Ext: \(ext)")
            
            fileName = String(describing: url.lastPathComponent) //PNG
            // print("From UIImagePickerControllerReferenceURL")
            // print("File Size: \(fileSize)")
            // print("File Name: \(fileName)")
            attachmentFileName = fileName
            
            if fileName.hasSuffix(".png") || fileName.hasSuffix(".PNG"){
                
                mimeType = "image/png"
            }
            else if fileName.hasSuffix(".jpg") || fileName.hasSuffix(".JPG"){
                
                mimeType = "image/jpg"
            }
            else if fileName.hasSuffix(".jpeg") || fileName.hasSuffix(".JPEG"){
                
                mimeType = "image/jpeg"
            }
            else{
                mimeType = "image/jpg"
            }
        }
        else{
            //   print("From Camera Upload")  //JPG //jpg
            attachmentFileName = "\(String(format: "%.0f", Date().timeIntervalSince1970 * 1000)).PNG"
            mimeType = "image/jpg"
        }
        
        
        simpleImagePicker!.dismiss(animated: true)
       
        if DBHandler.appDelegateShared().isConnectedToNetwork().rawValue != 0
        {
            myImageUploadRequest()
        }
       
        
    }
    
    func myImageUploadRequest(){
        
        ProgressHUD.show("Uploading...")
        let imgData = UIImageJPEGRepresentation(selectedImage!,0.5)
        
        //let csrfTokenValue = UserDefaults.standard.string(forKey: "csrftoken")
        var  csrfTokenValue = ""
        if (AppUtilities.getCSFRToken() != nil)
        {
            csrfTokenValue = AppUtilities.getCSFRToken()
        }
        
        var patientSlugValue = ""
        let lPatient = AppUtilities.getCurrentSelectedPatientInMyFamily()
        
        if lPatient!.patient_slug != nil {
            patientSlugValue = lPatient!.patient_slug!
        } else {
            patientSlugValue = ""
        }
        
        let parameters = [
            "patient_slug" : patientSlugValue,
            "upload_type": "baby_bump_tracker",
            "month": monthValue]
        
        let headersParams: HTTPHeaders = [
            "X-CSRFToken": csrfTokenValue,
        ]
        
        let urlPath  =   AppUtilities.getBaseURL() + kUploadImagesForBBT
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            // MultipartFormData.append(imgData!, withName: "file", fileName: self.attachmentFileName, mimeType: self.mimeType) // this wont work
            multipartFormData.append(imgData!, withName: "file", fileName: self.attachmentFileName, mimeType: "image/jpeg")
            
        }, usingThreshold: UInt64.init(), to: urlPath, method: .post, headers: headersParams) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    //print(response.result)
                    // print(response.result.value!)
                    
                    if let jsonDict = response.result.value as? NSDictionary {
                        
                        if let msg = jsonDict.object(forKey: "status_message") as? String {
                            
                            showAlert(title: "Success", message: msg, vc: self)
                            
                            DispatchQueue.main.async() {
                                self.mainTableView.reloadData()
                                ProgressHUD.dismiss()
                            }
                        }
                        else{
                            //
                            if let msgDetails = jsonDict.object(forKey: "detail") as? String{
                                
                                showAlert(title: "Error", message: msgDetails, vc: self)
                            }else{
                                
                                showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                            }
                        }
                        
                        ProgressHUD.dismiss()
                    }
                    else{
                         //json error
                        showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                        ProgressHUD.dismiss()
                    }
                    
                }
                
            case .failure(let encodingError):
                // print(encodingError)
                showAlert(title: "Error", message: encodingError as! String, vc: self)
                ProgressHUD.dismiss()
                break
            }
        }
        
        
        /*   Alamofire.upload(
         multipartFormData: { MultipartFormData in
         
         for (key, value) in parameters {
         MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
         }
         // MultipartFormData.append(imgData!, withName: "file", fileName: self.attachmentFileName, mimeType: self.mimeType) // this wont work
         MultipartFormData.append(imgData!, withName: "file", fileName: self.attachmentFileName, mimeType: "image/jpeg")
         
         },to: "\(urlPath)") { (result) in
         
         switch result {
         case .success(let upload, _, _):
         
         upload.responseJSON { response in
         print(response.result.value!)
         }
         
         case .failure(let encodingError):
         print(encodingError)
         break
         }
         
         
         } */
        
    }
    
    
    
    /* Code for Swift 4.2 and Swift 5
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
     
     } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
     
     } else {
     print("Something went wrong")
     }
     } */
    
    //MARK: Navigation and Bottom Buttons
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        if selectedImage != nil{
            selectedImage = nil
            GlobalVariables.sharedManager.babyImgUrl = nil
            NotificationCenter.default.post(name: Notification.Name("GetImagesRefreshCall"), object: nil)
        }else{
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func emergencyButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
    }
    
    
    @IBAction func notificationButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "Notifications") as! Notifications
        if ((self.navigationController?.topViewController?.isKind(of: Notifications.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }
    
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let searchVC: SearchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        if ((self.navigationController?.topViewController?.isKind(of: SearchViewController.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
        
    }
}

