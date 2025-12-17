-- Seed data: Complete callings import
-- Generated from master_callings.csv
-- Run AFTER schema.sql

-- ============================================
-- STEP 1: Insert all unique people
-- ============================================

INSERT INTO people (full_name) VALUES
('(None called)'),
('A. Boyd Hansen'),
('A. Carlisle MacKay'),
('A. Dee Moultrie'),
('A. Tedd Richards'),
('A. Wayne Fox'),
('Aaron M. Coombs'),
('Abel M. Chavez Sr.'),
('Ada S. Haacke'),
('Adam C. Olson'),
('Adam C. Orson'),
('Afton S. Beesley'),
('Alan B. Weaver'),
('Alan C. Jacobs'),
('Alan L. Stine'),
('Alan P. Ostler'),
('Alden M. Higgs'),
('Alene B. Pedersen'),
('Allen L. Vance'),
('Allen N. Whipple'),
('Alvin E. Rickers'),
('Alvin J. Mitchell'),
('Alvin Kieffer'),
('Andrea L. Regis'),
('Andrew R. Fry'),
('Angela J. Fennemore'),
('Ann S. Allan'),
('Anthony S. Vance'),
('Apollo D. Moser'),
('Ardel K. Moffett'),
('Ardeth G. Kapp'),
('Ariel A. Hulse'),
('Arlein W. Brown'),
('Arlene C. Moultrie'),
('Arnold Lombardi'),
('Austin F. Whitmer'),
('Austin R. Sargent'),
('Avon T. Francis'),
('Barbara P. Julander'),
('Barrie G. McKay'),
('Barryington T. Wride'),
('Benjamin I. Martinez'),
('Bernell W. Coons'),
('Bert L. Johnson'),
('Betty J. Tingey'),
('Betty U. Robison'),
('Blaine J. Kay'),
('Blake K. Wade'),
('Blake W. Moore'),
('Boyd V. Rydalch'),
('Brady J. Anderson'),
('Brady S. Anderson'),
('Brandon G. Brown'),
('Brandon T. Toone'),
('Brent M. Watson'),
('Bret C. Morgan'),
('Bret G. Dixon'),
('Brett M. Pattison'),
('Brian L. Black'),
('Brian O. Casper'),
('Broderick V. Buttars'),
('Brooke L. Anderson'),
('Bruce E. Barlow'),
('Bruce J. Moore'),
('Bruce L. Ashton'),
('Bruce T. Davis'),
('Bryant J. Dresher'),
('Bryce W. Memmott'),
('Buddy K. Funk'),
('C. Evan Moss'),
('C. Lloyd Walch'),
('C. Scott Johnson'),
('Calvin P. Christensen'),
('Cameron C. Kent'),
('Cami C. Watson'),
('Carol J. Moore'),
('Carol L. Barlow'),
('Carolyn J. Kunz'),
('Carolyn L. Bean'),
('Carolyn W. Zaugg'),
('Carolyn Y. Hunsaker'),
('Cary A. Lowe'),
('Charity Dabel'),
('Charles R. Hughes Jr.'),
('Chester F. Redd'),
('Chris D. Partridge'),
('Christopher J. Doherty'),
('Christopher M. Jenkins'),
('Christopher S. Miller'),
('Clarence C. Neslen Jr.'),
('Clark B. Watson'),
('Clark M. Mower'),
('Clark Richardson'),
('Claude L. Mills'),
('Claude R. Snow'),
('Clifford H. Poulsen'),
('Clifton C. Clark'),
('Clifton I. Johnson'),
('Clyde C. Page'),
('Clyde F. Smith'),
('Clyde S. St. Clair'),
('Clyde W. Mills'),
('Clyde W. Willey'),
('Colby J. Higginson'),
('Colin B. Van Orman'),
('Colin W. Skinner'),
('Colleen L. Parker'),
('Connie M. Burns'),
('Connie W. Foy'),
('Cory F. Hanks'),
('Courtney L. Childs'),
('Craig L. Randall'),
('Craige J. Olson'),
('Curtis B. Knudsen'),
('Curtis E. Bingham'),
('Cynthia M. Stanger'),
('D. Allen Jameson'),
('D. Louise DeMoux'),
('D. Rodney Graham'),
('D. Walter Scott Jr.'),
('Dana E. Morgan'),
('Darrell S. Taylor'),
('Darryl F. Nelson'),
('David A. Orson'),
('David A. Russell'),
('David B. Graham'),
('David B. Walch'),
('David C. Bradford'),
('David E. Larsen'),
('David G. Angerbauer'),
('David H. Wray'),
('David K. Balling'),
('David L. Anderson'),
('David M. Williams'),
('David R. Hall'),
('David T. Scarlet'),
('Dawn H. Bain'),
('DeLoise L. Robins'),
('DeMar B. Riley'),
('DeVor Moss'),
('Dean B. Cleverly'),
('Deidra Thueson'),
('Delbert H. Strasser'),
('Delbert R. Duerden'),
('Delene H. Keddington'),
('Delmont Hayes'),
('Delores Kelson'),
('Denese P. Adams'),
('Denis B. Longhurst'),
('Dennis C. Winter'),
('Dennis P. Jensen'),
('Denton R. Johnson'),
('Devon O. Steiner'),
('Dewey C. MacKay Jr.'),
('DiAnne F. Campbell'),
('Diane E. Jensen'),
('Dixie G. Allen'),
('Don Spainhower'),
('Don W. Tibbitts'),
('Donald E. Rose'),
('Donald F. Owen'),
('Donald L. Braden'),
('Donald L. Showalter III'),
('Donald W. Patterson'),
('Dorothy B. Taylor'),
('Dorothy McArthur'),
('Douglas B. Eggett'),
('Douglas B. Taylor'),
('Douglas J. Hammond'),
('Douglas L. Boulton'),
('Douglas W. Osborn'),
('Doyle L. Swenson'),
('Doyle P. Shurtz'),
('Duane K. Orchard'),
('Duane R. Harrison'),
('Durant Thompson'),
('Dwayne S. McOmie'),
('Dwight J. Williams'),
('E. Gail Anger'),
('E. Jay Goodman'),
('E. Ryan Miller'),
('Earl D. Winger'),
('Earl G. Jones'),
('Earl M. Zaugg'),
('Earl S. Jones'),
('Edith P. Sharp'),
('Edward Dawson'),
('Edward W. Ancell'),
('Elaine J. Sargent'),
('Elaine N. Carlisle'),
('Eldeen W. Trimble'),
('Eleanor F. Hoagland'),
('Elmo J. Steed'),
('Elvon L. Bay'),
('Emily J. Miller'),
('Eric G. Eddings'),
('Eric N. Shegrud'),
('Eric S. Calder'),
('Ethan L. Robison'),
('Ethelyn D. Graham'),
('Eugene A. Peresich III'),
('Eugene J. Moore'),
('Eugene M. Hamilton'),
('Eulala H. Butters'),
('Eva C. Chambers'),
('Evelyn M. Beck'),
('F. Burton Howard'),
('F. Michael Watson'),
('Floyd D. Rasmussen'),
('Floyd E. Trimble'),
('Frank B. Newman Jr.'),
('Frank Craven'),
('Frank J. Sano'),
('G. Ernest Deters'),
('G. Preston Parker'),
('G. Tod Moss'),
('Gail E. Anger'),
('Gary B. Neilson'),
('Gary F. Damm'),
('Gary G. Cook'),
('Gary G. Rushton'),
('Gary L. Pedersen'),
('Gary L. Wall'),
('Gary P. Cox'),
('Gary R. Hill'),
('Gary W. Call'),
('Geoffrey R. Corey'),
('George Allan'),
('George S. Barrus'),
('Georgia W. Memmott'),
('Gerald N. Wray'),
('Gerald W. Day'),
('Gerald W. Robertson'),
('Gilbert M. Bean'),
('Gilbert R. Wilburn Jr.'),
('Gina A. Howard'),
('Glen F. Biddulph'),
('Glen G. Taylor'),
('Glen R. Simmons'),
('Glen T. Campbell'),
('Glenn A. Register'),
('Gloria Yeates'),
('Gordon I. Irving'),
('Gordon L. Carlson'),
('Gordon L. Fisher'),
('Gregory L. Allen'),
('Gregory P. Johns'),
('Gregory R. Misener'),
('H. Mifflin Williams III'),
('Hal R. Belnap'),
('Harl M. Noble'),
('Harold C. Secrist'),
('Harold K. Smith'),
('Harry A. Haycock'),
('Harvey L. Padley'),
('Heather D. Moyes'),
('Heber B. Kapp'),
('Heidi E. Miner'),
('Helen B. Horner'),
('Helen O. Madsen'),
('Henry A. Haurand'),
('Henry A. Mora'),
('Herbert E. Broughton'),
('Herbert F. Hoehne'),
('Hiram S. McDonald'),
('Holly A. Veigel'),
('Howard P. Stapley'),
('Howard S. Robison'),
('Hyde H. Frederickson'),
('Hyrum B. Nay'),
('Ira C. Beal'),
('Irene C. Hayes'),
('Ivan O. Jensen'),
('J. Bruce Smart'),
('J. Claine Petersen'),
('J. Donald West'),
('J. Drexel Beckman'),
('J. Duane Moyes'),
('J. Harry Malone'),
('J. Kent Galloway'),
('J. Orval Hayes'),
('J. Paul Millburn'),
('J. Richard Hanson Jr.'),
('J. Ross Lundgren'),
('J. Scott Allred'),
('J. Stanley Elmer'),
('J. Todd Wesche'),
('J. Wallace Cook'),
('J. Wayne Mason'),
('J.A. Guy Dugal'),
('J.D. Packard'),
('Jackson M. Anderson'),
('James A. Burns'),
('James A. Collier'),
('James B. De Moux'),
('James C. Burns'),
('James E. Rushforth'),
('James H. Fedor'),
('James L. Florence'),
('James M. Fackrell'),
('James M. Irvine'),
('James R. Lynch'),
('Jamie L. Christensen'),
('Jan V. McKee'),
('Jana R. Foy'),
('Janeal L. McOmie'),
('Janeal S. Magalei'),
('Janet J. Petersen'),
('Janette E. Pack'),
('Janice E. Tolman'),
('Janis F. Reeves'),
('Jason A. Wendel'),
('Jason J. Steenblik'),
('Jason W. Baxter'),
('Jay A. Anderson'),
('Jay L. Anderson'),
('Jay Livingood'),
('Jay R. Bingham'),
('Jean S. Green'),
('Jean T. Francis'),
('Jeanene Grimstead'),
('Jeffery A. Moyes'),
('Jeffery K. Johnson'),
('Jeffrey M. Hansen'),
('Jenifer J. Francis'),
('Jenifer J. Scott'),
('Jennifer L. Tooley'),
('Jerald W. Duggar'),
('Jeremy R. Holt'),
('Jerry M. Crawford'),
('Jerry S. Barker'),
('Jesse D. Bell'),
('Jessene M. Pack'),
('JoAnn L. Hanson'),
('JoLyn S. Baldwin'),
('Joanne (Jody) Pratt'),
('John A. Hermansen'),
('John A. Wood'),
('John E. Ingles'),
('John Gallacher'),
('John H. Allen'),
('John H. Mabey'),
('John H. Morgan'),
('John L. White'),
('John M. Powell'),
('John P. Esplin'),
('John R. Clawson'),
('John R. Fennemore'),
('John R. Kunz'),
('John R. Margetts'),
('John S. Smith'),
('John W. Best'),
('John W. Haacke'),
('Jolean G. Terry'),
('Jon L. Ringwood'),
('Jon Reed Boothe'),
('Jordan B. Livingston'),
('Joseph A. Hoggan'),
('Joseph C. Rust'),
('Joseph S. Grimstead'),
('Joshua A. Anderson'),
('Joshua E. Pay'),
('Joshua S. Grimstead'),
('Joyce A. Cox'),
('Joyce G. Shaum'),
('Joyce S. Mills'),
('Judy F. Wallace'),
('Judy R. Graham'),
('Julie A. Hall'),
('Julie E. Burdett'),
('Julie W. Dixon'),
('June S. Calder'),
('Justin A. Clarke'),
('K. Glen McArthur'),
('Kami M. Calder'),
('Kathleen B. Joy'),
('Kathleen K. Lindsay'),
('Kathleen S. Burningham'),
('Kay B. Cleverly'),
('Kay J. Collings'),
('Keith A. Beal'),
('Keith E. Archibald'),
('Keith E. Taylor'),
('Keith J. Beazer'),
('Keith M. Papenfuss'),
('Keith Paulsen'),
('Keith R. Riley'),
('Keith W. Schoenfeld'),
('Keli A. Rhodes'),
('Kelli N. Roberts'),
('Kelly B. Parsons'),
('Kelly M. Barnett'),
('Kenneth C. Pendleton'),
('Kenneth D. Taylor'),
('Kenneth G. Hansen'),
('Kenneth G. Toone'),
('Kenneth Howell'),
('Kenneth P. Schwab'),
('Kenneth Roy Young'),
('Kenneth W. Kinzel'),
('Kenneth W. Sugden'),
('Kent W. Hood'),
('Kevin L. Thueson'),
('Kevin R. Knight'),
('Kim M. Anderson'),
('Kimberly A. Austin'),
('Kimberly M. Davis'),
('Kirk P. Thomas'),
('Kirk R. Anderson'),
('Kirk R. Stephens'),
('Kristi S. Black'),
('Kristie J. Swain'),
('Kyle W. Dimond'),
('L. Cameron Williamsen'),
('L. Don LeFevre'),
('L. Kenneth Olson'),
('L. Woodruff Stout'),
('LaMont V. Fowler'),
('LaNae W. Simmons'),
('LaVance P. Nelson'),
('LaVar C. Murri'),
('Lance D. Beard'),
('Lance D. Regis'),
('Lance L. Wood'),
('Lance R. Gilbert'),
('Lance W. Mercer'),
('Larissa H. Humphries'),
('Larry A. Carter'),
('Larry D. Hafen'),
('Larry D. Veigel'),
('Larry E. Fuller'),
('Larry K. Ward'),
('Larry L. Young'),
('Laura A. Brady'),
('Laureen H. Anderson'),
('Laurette Judd'),
('Laurie G. Barker'),
('Layton P. Ott'),
('LeAnne S. West'),
('Lee Ann Beard'),
('Lee Ann C. Sargent'),
('Lee W. Moss'),
('Lela M. Bangerter'),
('Leon D. Lundquist'),
('Leslie D. Lawrence'),
('Leslie M. Atkinson'),
('Leslie T. Foy'),
('Lester B. Lee'),
('Linda Clark'),
('Linda Stine'),
('Lionel B. Farr'),
('Lisa D. Wall'),
('Lois B. Passey'),
('Lois G. Webster'),
('Lois Hoskins'),
('Lois Kieffer'),
('Lois L. Sargent'),
('Lola Mae A. Taylor'),
('Lonna J. Sadler'),
('Lorraine G. Galloway'),
('Lorraine L. Moss'),
('Lorraine M. Moyes'),
('Lothair W. Thompson'),
('Louise E. Stout'),
('Lyle N. Cole'),
('Lyle R. Peterson'),
('Lyle S. Hintze'),
('Lynn D. McKee'),
('Lynn E. Zabriskie'),
('Lynn M. Austin'),
('Lynn R. Clement'),
('Lynn S. Lundquist'),
('M. Ben West'),
('M. Neil Cleverly'),
('M. Newell Tingey'),
('Marc B. Johnson'),
('Marcia D. Beck'),
('Marcia R. Mercer'),
('Margaret Nielsen'),
('Margaret R. Nelson'),
('Marilee V. Esplin'),
('Marilla H. Sessions'),
('Marilyn M. Allen'),
('Mark C. Marchant'),
('Mark C. Stanger'),
('Mark C. Swain'),
('Mark L. Williams'),
('Mark M. Zaugg'),
('Mark V. Erickson'),
('Marla D. Burns'),
('Marlow J. Young'),
('Martin D. Christensen'),
('Martin L. Halverson'),
('Marvin A. Magalei'),
('Mary Ann D. Smith'),
('Mary Lou B. Strasser'),
('Matthew C. Murri'),
('Matthew F. Nelson'),
('Matthew J. Brady'),
('Matthew K. Judd'),
('Matthew R. Brady'),
('Matthew T. Palfreyman'),
('Maurice J. Clay'),
('Max B. Welcker'),
('Max D. Wallace'),
('Max T. Kieffer'),
('Maxine B. Duerden'),
('May C. McConkie'),
('Mehl Ree D. Downard'),
('Melvin H. Robins'),
('Melvin J. Ericksen'),
('Meredith A. Martinez'),
('Meredith Palfreyman'),
('Meril Lyn Stenquist'),
('Merlin K. Partridge'),
('Merrill W. Beck'),
('Michael D. Huff'),
('Michael J. Esplin'),
('Michael J. Flynn'),
('Michael J. Lott'),
('Michael L. Van Dam'),
('Michael L. Verkler'),
('Michael R. Seegmiller'),
('Michael T. Mason'),
('Michael W. Beck'),
('Michael W. Crippen'),
('Michael W. Showalter'),
('Michelle C. Hanks'),
('Michelle D. Misener'),
('Miles I. Miller'),
('Milton K. Shaum'),
('Mitchell B. Spence'),
('Mitchell W. Lonnecker'),
('Morris F. Swapp'),
('Myrne M. Collier'),
('N. Grant Butters'),
('N. James Cole'),
('Nancy Davis'),
('Nannette P. White'),
('Nannette Stone'),
('Nathan D. Rogers'),
('Nathan J. Arvidson'),
('Nathan R. Wuthrich'),
('Ned M. Vowles'),
('Neil W. Kooyman'),
('Newell J. Bryson'),
('Nola Gay Goodfellow'),
('Nolan E. Ransom'),
('Norma Edwards'),
('Norma J. West'),
('Norma Jo S. Vance'),
('Norma L. Ostler'),
('Norma Livingood'),
('Norman G. Ainscough'),
('Norman H. Goodfellow'),
('Norman R. Hammond'),
('Norman T. Marchant'),
('Odell Dale Anderson'),
('Otto Van Ry'),
('Pamela W. Wood'),
('Parker W. Ussery'),
('Patsy C. Jeppsen'),
('Patti K. Williams'),
('Paul E. Barlow'),
('Peggy W. Showalter'),
('Percy E. Burrup'),
('Percy W. Pratt'),
('Phillip D. Houghton'),
('Phillip R. Barber'),
('R. Eberhard Sommer'),
('R. Randle Romney'),
('R. Scott Erskine'),
('R. Thomas Woodland'),
('R. Vincent Ord'),
('R. Willis Orton'),
('Ralph A. Watt'),
('Ralph E. Angerbauer'),
('Ralph P. Pond'),
('Randy F. Jackson'),
('Randy S. Beyer'),
('Ray A. Christensen'),
('Ray B. Tolman'),
('Ray L. Sargent'),
('Raymond D. Cook'),
('Rebecca M. Seegmiller'),
('Rebecca T. Stahle'),
('Reese K. Allen'),
('Renn D. Madsen'),
('Rex L. Christensen'),
('Rhea K. Palmer'),
('Richard A. Page'),
('Richard C. Jensen'),
('Richard D. Foster'),
('Richard F. Reeder'),
('Richard G. Reeder'),
('Richard G. Sharp'),
('Richard G. Southwick'),
('Richard I. Woolley'),
('Richard J. Lawrence'),
('Richard M. Downward'),
('Richard S. Prows'),
('Richard T. Derr'),
('Richard Tingey'),
('Richard V. Wall'),
('Robert A. Gelder'),
('Robert D. Davis'),
('Robert D. Todd'),
('Robert E. Crouch'),
('Robert E. Joffs'),
('Robert G. Haire'),
('Robert G. Irvine'),
('Robert J. Little'),
('Robert K. Lake'),
('Robert M. Craven'),
('Robert M. Horner'),
('Robert M. Moncur Jr.'),
('Robert M. Wilkes Jr.'),
('Robert S. Lee'),
('Robert W. Carlson'),
('Robert W. Jeppsen'),
('Roger D. Phillips'),
('Roger G. Shumway Jr.'),
('Ronald D. Duerden'),
('Ronald H. Matthews'),
('Ronald Romney'),
('Ross H. Wentworth'),
('Roy S. Passey'),
('Ruth W. Swenson'),
('Ryan D. Anderson'),
('Ryan D. Moyes'),
('S. Brantz Gentry'),
('Samuel D. Johnson'),
('Samuel J. Bawden'),
('Sara A. Weston'),
('Scott B. Davis'),
('Scott G. Lemon'),
('Scott L. Larsen'),
('Scott R. Barnes'),
('Shannon A. Andrews'),
('Sharon M. Millburn'),
('Shaun D. Stahle'),
('Shauna A. Brady'),
('Shellise Watson'),
('Sheral V. Karren'),
('Sheri B. Stark'),
('Sherry M. Johnson'),
('Sherry W. Rodriguez'),
('Simeon J. Wolfgramm'),
('Sisson C. Hatch'),
('Skyler J. Trujillo'),
('Spencer D. Arntsen'),
('Spencer L. Winegar'),
('Spencer M. Hadley'),
('Spencer R. Stark'),
('Stacy L. Knight'),
('Stanley P. Ferguson'),
('Stephanie D. Young'),
('Stephen G. Carter'),
('Stephen M. Hadley'),
('Sterling E. Beesley'),
('Sterling G. Umphenour Jr.'),
('Sterling L. Barker'),
('Steven E. Joy'),
('Steven G. Farley'),
('Steven L. Brown'),
('Steven L. Thueson'),
('Steven R. Merkley'),
('Steven S. Davis'),
('Susan A. Damm'),
('Susan B. Olson'),
('Susan L. Williams'),
('Sylvia Carter'),
('Sylvia R. Steen'),
('Syrenna L. Losee'),
('T. Richard Downard'),
('Ted A. Holt'),
('Ted F. Powell'),
('Terry J. Spallino'),
('Thelda Bowers'),
('Thelma W. Gibson'),
('Thomas L. McLachlan'),
('Thomas V. Foy'),
('Toby N. Hawkins'),
('Todd H. Campbell'),
('Tommie G. Matthews'),
('Tracey A. Florence'),
('Trent B. Barker'),
('Trent K. Hodgson'),
('Trevor L. Austin'),
('Trissy J. Bawden'),
('Troy M. Anderson'),
('Trudee H. Fuller'),
('Tyrel R. King'),
('Tyson C. Beck'),
('Tyson C. Stevens'),
('V. Lloyd Haynie'),
('Val S. Stringfellow'),
('Valeen S. Jensen'),
('Valentine J. Munoz Jr.'),
('Vance H. Walker'),
('Vanda C. Lewis'),
('Verla Haynie'),
('Verlyn D. Hawks'),
('Vern N. Christensen'),
('Vernon W. Graham'),
('Vernon Y. Jensen'),
('Vicki S. Parsons'),
('Victor G. Mason'),
('Vida P. Bennett'),
('Vincent K. Humphries'),
('Virginia L. Regis'),
('W. Anthony Gilvear'),
('W. Bret Holbrook'),
('W. Conrad Bowen'),
('W. Dean Belnap'),
('W. Robert McLaughlin'),
('W. Thomas Crosby'),
('W. Troy Burnett'),
('Wade H. Pickett'),
('Walter D. Talbot'),
('Wanee I. Welch'),
('Ward C. Holbrook'),
('Wayne H. Swenson'),
('Wayne M. Beck'),
('Weldon H. Woozley'),
('Weldon M. Egbert'),
('Wells V. Wilkinson'),
('Wendell N. Moon'),
('Wendell R. Fackrell'),
('Wesley E. White'),
('William A. Blankenagel'),
('William A. Hoagland'),
('William E. Sargent'),
('William H. Bennett'),
('William L. Brown'),
('William L. Page'),
('William Robert McConkie'),
('William T. Terry');


-- ============================================
-- STEP 2: Insert callings using lookups
-- ============================================

-- We need to map organization names from CSV to database
-- and position titles similarly

DO $$
DECLARE
    v_person_id UUID;
    v_org_id UUID;
    v_position_id UUID;
BEGIN

    -- Assistant Stake Clerk
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Assistant Stake Clerk';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jay R. Bingham';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1961-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman H. Goodfellow';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-01-01', 'year', '1965-11-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan B. Weaver';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1961-03-19', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Frank B. Newman Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1963-10-21', 'exact', '1970-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harold C. Secrist';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1965-11-22', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn E. Zabriskie';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-10-08', 'exact', '1970-01-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan C. Jacobs';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-10-08', 'exact', '1969-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gilbert M. Bean';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1969-03-16', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary L. Wall';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1970-01-04', 'exact', '1970-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'M. Ben West';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-03-21', 'exact', '1973-01-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Chester F. Redd';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-03-21', 'exact', '1971-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gordon I. Irving';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1972-03-19', 'exact', '1994-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John W. Haacke';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1972-10-01', 'exact', '1974-09-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'G. Preston Parker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1973-01-07', 'exact', '1978-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John W. Haacke';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1975-06-24', 'exact', '1989-10-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Thomas Crosby';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1978-06-11', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Avon T. Francis';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1981-03-01', 'exact', '1982-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert K. Lake';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1981-01-01', 'year', '1983-01-01', 'year', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jon Reed Boothe';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1982-01-01', 'year', '1987-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ariel A. Hulse';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1989-10-15', 'exact', '1991-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Raymond D. Cook';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1992-07-01', 'month', '1999-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James H. Fedor';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1994-06-12', 'exact', '1997-06-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hiram S. McDonald';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1998-06-07', 'exact', '2007-03-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew K. Judd';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2001-03-04', 'exact', '2002-03-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wendell R. Fackrell';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2004-03-07', 'exact', '2006-11-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven L. Brown';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2006-11-04', 'exact', '2011-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth Howell';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2011-09-11', 'exact', '2014-06-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gregory L. Allen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2014-06-01', 'exact', '2017-04-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jerry S. Barker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2016-06-15', 'exact', '2017-12-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Christopher S. Miller';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2017-04-30', 'exact', '2022-12-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bryant J. Dresher';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk - Technology';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2017-12-03', 'exact', '2019-12-08', 'exact', 'Technology');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Justin A. Clarke';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk - Technology';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2019-12-08', 'exact', NULL, NULL, 'Technology - Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard G. Reeder';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2022-12-18', 'exact', NULL, NULL, 'Current');

    -- Bountiful 14th Ward
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Bountiful 14th Ward';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Wayne Mason';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1956-12-30', 'exact', '1961-01-22', 'exact', 'Organized from Bountiful 4th and 7th wards 30 December 1956');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David A. Russell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1956-12-30', 'exact', '1961-01-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harold C. Secrist';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1956-12-30', 'exact', '1961-01-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Drexel Beckman';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1961-01-22', 'exact', '1966-09-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde C. Page';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1961-01-22', 'exact', '1966-09-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dwight J. Williams';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1961-01-22', 'exact', '1963-12-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John H. Morgan';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1963-12-15', 'exact', '1966-09-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Renn D. Madsen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1966-09-18', 'exact', '1970-05-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert W. Carlson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1966-09-18', 'exact', '1970-05-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'A. Dee Moultrie';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1966-09-18', 'exact', '1970-05-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard G. Southwick';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1970-05-24', 'exact', '1972-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James A. Collier';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1970-05-24', 'exact', '1972-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Miles I. Miller';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1970-05-24', 'exact', '1972-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Miles I. Miller';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1972-01-09', 'exact', '1979-10-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'A. Dee Moultrie';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1972-01-09', 'exact', '1978-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Boyd V. Rydalch';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1978-03-16', 'exact', '1979-10-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Boyd V. Rydalch';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1972-01-09', 'exact', '1978-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard J. Lawrence';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1978-03-16', 'exact', '1979-10-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'A. Dee Moultrie';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1979-10-21', 'exact', '1985-02-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary G. Rushton';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1979-10-21', 'exact', '1985-02-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas L. Boulton';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1979-10-21', 'exact', '1981-04-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Victor G. Mason';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1981-04-26', 'exact', '1985-02-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Boyd V. Rydalch';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1985-02-17', 'exact', '1988-08-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard J. Lawrence';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1985-02-17', 'exact', '1988-08-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John P. Esplin';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1985-02-17', 'exact', '1988-08-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Paul Millburn';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1988-08-14', 'exact', '1994-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael W. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1988-08-14', 'exact', '1992-10-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance L. Wood';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1992-10-11', 'exact', '1994-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance L. Wood';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1988-08-14', 'exact', '1992-10-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bret C. Morgan';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1992-10-11', 'exact', '1994-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael W. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1994-01-09', 'exact', '1999-02-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gilbert R. Wilburn Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1994-01-09', 'exact', '1996-06-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert W. Jeppsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1996-06-02', 'exact', '1999-02-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert W. Jeppsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1994-01-09', 'exact', '1996-06-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bret C. Morgan';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1996-06-02', 'exact', '1999-02-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bret C. Morgan';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1999-02-21', 'exact', '2005-02-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kirk R. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1999-02-21', 'exact', '2002-04-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew J. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2002-04-28', 'exact', '2005-02-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew J. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1999-02-21', 'exact', '2002-04-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark L. Williams';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2002-04-28', 'exact', '2003-09-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Merlin K. Partridge';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2003-09-21', 'exact', '2005-02-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew J. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2005-02-20', 'exact', '2010-09-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew K. Judd';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2005-02-20', 'exact', '2008-04-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Paul E. Barlow';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2008-04-20', 'exact', '2010-09-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James M. Fackrell';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2005-02-20', 'exact', '2008-04-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Anthony Gilvear';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2008-04-20', 'exact', '2010-09-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Thomas L. McLachlan';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2010-09-05', 'exact', '2014-08-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary W. Call';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2010-09-05', 'exact', '2014-08-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary F. Damm';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2010-09-05', 'exact', '2014-08-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eric S. Calder';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2014-08-24', 'exact', '2019-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary F. Damm';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2014-08-24', 'exact', '2017-03-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vernon W. Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2017-03-12', 'exact', '2018-01-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance W. Mercer';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2018-01-07', 'exact', '2019-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance L. Wood';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2014-08-24', 'exact', '2016-03-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vernon W. Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2016-03-13', 'exact', '2017-03-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance W. Mercer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2017-03-12', 'exact', '2018-01-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven G. Farley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2018-01-07', 'exact', '2019-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance L. Wood';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2019-09-15', 'exact', '2024-03-24', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James M. Fackrell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2019-09-15', 'exact', '2021-04-18', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ross H. Wentworth';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2019-09-15', 'exact', '2021-04-18', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ross H. Wentworth';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2021-04-18', 'exact', '2024-03-24', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven G. Farley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2021-04-18', 'exact', '2023-01-08', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew C. Murri';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2023-01-08', 'exact', '2024-03-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary F. Damm';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2024-03-24', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'C. Scott Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2024-03-24', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Samuel D. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2024-03-24', 'exact', '2024-08-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'L. Cameron Williamsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2024-08-18', 'exact', NULL, NULL, 'Current');

    -- Bountiful 15th Ward
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Bountiful 15th Ward';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Bruce Smart';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1957-04-21', 'exact', '1962-05-20', 'exact', 'Organized from Bountiful 2nd Ward 21 April 1957');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'George S. Barrus';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1957-04-21', 'exact', '1957-07-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Don W. Tibbitts';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1957-07-28', 'exact', '1962-05-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Don W. Tibbitts';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1957-04-21', 'exact', '1957-07-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth Roy Young';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1957-07-28', 'exact', '1958-05-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard I. Woolley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-05-25', 'exact', '1962-05-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Floyd E. Trimble';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-05-20', 'exact', '1972-04-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Harry Malone';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-05-20', 'exact', '1963-08-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alden M. Higgs';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1963-08-18', 'exact', '1968-06-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth G. Toone';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1968-06-09', 'exact', '1972-04-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alden M. Higgs';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-05-20', 'exact', '1963-08-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Don Spainhower';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1963-08-18', 'exact', '1965-07-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth G. Toone';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1965-07-25', 'exact', '1968-06-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Colin W. Skinner';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1968-06-09', 'exact', '1971-01-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'E. Jay Goodman';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1971-01-17', 'exact', '1972-04-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'DeVor Moss';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1972-04-23', 'exact', '1977-06-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ronald H. Matthews';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1972-04-23', 'exact', '1972-11-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard D. Foster';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1972-11-12', 'exact', '1975-06-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn D. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1975-06-29', 'exact', '1976-03-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David T. Scarlet';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1976-03-21', 'exact', '1977-06-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard D. Foster';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1972-04-23', 'exact', '1972-11-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Tommie G. Matthews';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1972-11-12', 'exact', '1974-04-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn D. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1974-04-21', 'exact', '1975-06-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Eberhard Sommer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1975-06-29', 'exact', '1977-06-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn D. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-06-19', 'exact', '1982-02-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen T. Campbell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-06-26', 'exact', '1980-09-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hyrum B. Nay';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1980-09-21', 'exact', '1982-02-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Herbert E. Broughton';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-06-19', 'exact', '1980-09-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'DeMar B. Riley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1980-09-21', 'exact', '1982-02-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth G. Toone';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1982-02-28', 'exact', '1986-08-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hyrum B. Nay';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1982-02-28', 'exact', '1986-08-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'DeMar B. Riley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1982-02-28', 'exact', '1984-07-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William E. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1984-07-08', 'exact', '1986-08-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Eberhard Sommer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1986-08-31', 'exact', '1992-01-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen T. Campbell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1986-08-31', 'exact', '1992-01-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry D. Veigel';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1986-08-31', 'exact', '1992-01-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry D. Veigel';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1992-01-12', 'exact', '1995-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas J. Hammond';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1992-01-12', 'exact', '1995-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark C. Marchant';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1992-01-12', 'exact', '1994-11-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith M. Papenfuss';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1994-11-27', 'exact', '1995-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William E. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1995-06-11', 'exact', '1999-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas J. Hammond';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1995-06-11', 'exact', '1995-08-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith M. Papenfuss';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1995-08-27', 'exact', '1996-10-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert E. Crouch';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1996-10-13', 'exact', '1999-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith M. Papenfuss';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1995-06-11', 'exact', '1995-08-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert E. Crouch';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1995-08-27', 'exact', '1996-10-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Devon O. Steiner';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1996-10-13', 'exact', '1999-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Cory F. Hanks';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1999-06-06', 'exact', '2005-07-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Verlyn D. Hawks';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1999-06-06', 'exact', '2003-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Nolan E. Ransom';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2003-11-16', 'exact', '2005-07-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Nolan E. Ransom';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1999-06-06', 'exact', '2003-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John W. Best';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2003-11-16', 'exact', '2005-07-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Shaun D. Stahle';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2005-07-31', 'exact', '2011-05-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Fennemore';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2005-07-31', 'exact', '2008-09-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mitchell W. Lonnecker';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2008-09-28', 'exact', '2009-12-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brady J. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2009-12-27', 'exact', '2011-05-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mitchell W. Lonnecker';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2005-07-31', 'exact', '2008-09-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brady J. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2008-09-28', 'exact', '2009-12-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William A. Blankenagel';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2009-12-27', 'exact', '2011-05-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Verlyn D. Hawks';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2011-05-22', 'exact', '2016-08-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William A. Blankenagel';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2011-05-22', 'exact', '2013-11-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kevin R. Knight';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2013-11-10', 'exact', '2014-03-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jason A. Wendel';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2014-03-30', 'exact', '2016-08-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kevin R. Knight';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2011-05-22', 'exact', '2013-11-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jason A. Wendel';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2013-11-10', 'exact', '2014-03-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl M. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2014-03-30', 'exact', '2016-08-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kevin R. Knight';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2016-08-14', 'exact', '2021-08-22', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Parker W. Ussery';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2016-08-14', 'exact', '2018-03-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer L. Winegar';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2018-03-11', 'exact', '2020-12-27', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith A. Beal';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2020-12-27', 'exact', '2021-08-22', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer L. Winegar';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2016-08-14', 'exact', '2018-03-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith A. Beal';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2018-03-11', 'exact', '2020-12-27', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Colby J. Higginson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2020-12-27', 'exact', '2021-08-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Curtis B. Knudsen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2021-08-22', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Scott R. Barnes';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2021-08-22', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Tyson C. Stevens';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2021-08-22', 'exact', NULL, NULL, 'Current');

    -- Bountiful 20th Ward
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Bountiful 20th Ward';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John L. White';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1961-04-30', 'exact', '1967-04-23', 'exact', 'Organized from Bountiful 4th Ward 30 April 1961');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Melvin J. Ericksen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1961-04-30', 'exact', '1967-04-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen G. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1961-04-30', 'exact', '1964-11-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn E. Zabriskie';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1964-11-08', 'exact', '1967-04-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith J. Beazer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1967-04-23', 'exact', '1972-06-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Walter D. Talbot';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1967-04-23', 'exact', '1969-07-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Arnold Lombardi';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1969-07-27', 'exact', '1971-02-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth W. Kinzel';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1971-02-21', 'exact', '1972-06-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman R. Hammond';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1967-04-23', 'exact', '1969-07-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth W. Kinzel';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1969-07-27', 'exact', '1971-02-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman R. Hammond';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1971-02-21', 'exact', '1972-06-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen G. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1972-06-25', 'exact', '1977-02-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gail E. Anger';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1972-06-25', 'exact', '1974-12-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn M. Austin';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1974-12-08', 'exact', '1975-08-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Ross Lundgren';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1975-08-10', 'exact', '1977-02-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry L. Young';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1972-06-25', 'exact', '1974-12-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Ross Lundgren';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1974-12-08', 'exact', '1975-08-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alvin E. Rickers';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1975-08-10', 'exact', '1977-02-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Donald West';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-02-13', 'exact', '1980-07-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wayne H. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-02-13', 'exact', '1980-07-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Val S. Stringfellow';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-02-13', 'exact', '1978-10-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jay L. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1978-10-29', 'exact', '1980-07-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jay L. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1980-07-27', 'exact', '1985-07-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wayne H. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1980-07-27', 'exact', '1985-07-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bruce L. Ashton';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1980-07-27', 'exact', '1985-07-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delbert H. Strasser';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1985-07-14', 'exact', '1991-01-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ronald D. Duerden';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1985-07-14', 'exact', '1991-01-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dean B. Cleverly';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1985-07-14', 'exact', '1987-03-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Willis Orton';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1987-03-15', 'exact', '1988-09-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard P. Stapley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1988-09-04', 'exact', '1991-01-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'E. Gail Anger';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1991-01-20', 'exact', '1996-01-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jan V. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1991-01-20', 'exact', '1996-01-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ralph P. Pond';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1991-01-20', 'exact', '1994-05-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Scott Allred';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1994-05-29', 'exact', '1996-01-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dean B. Cleverly';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1996-01-28', 'exact', '2001-06-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry L. Young';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1996-01-28', 'exact', '1998-09-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kevin L. Thueson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1998-09-23', 'exact', '1999-02-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hyde H. Frederickson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1999-02-28', 'exact', '2001-06-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kevin L. Thueson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1996-01-28', 'exact', '1998-09-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hyde H. Frederickson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1998-09-23', 'exact', '1999-02-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lionel B. Farr';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1999-02-28', 'exact', '2001-06-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hyde H. Frederickson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2001-06-10', 'exact', '2006-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith R. Riley';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2001-06-10', 'exact', '2006-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trevor L. Austin';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2001-06-10', 'exact', '2006-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance D. Regis';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2006-06-04', 'exact', '2011-11-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bret G. Dixon';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2006-06-04', 'exact', '2011-11-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Adam C. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2006-06-04', 'exact', '2010-04-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Troy M. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2010-04-25', 'exact', '2011-11-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Troy M. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2011-11-06', 'exact', '2014-10-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lionel B. Farr';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2011-11-06', 'exact', '2014-10-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ethan L. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2011-11-06', 'exact', '2014-10-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Adam C. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2014-10-12', 'exact', '2019-12-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark C. Stanger';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2014-10-12', 'exact', '2019-12-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ryan D. Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2014-10-12', 'exact', '2016-10-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Tyrel R. King';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2016-10-23', 'exact', '2018-04-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Parker W. Ussery';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2018-04-28', 'exact', '2019-06-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eric N. Shegrud';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2019-06-23', 'exact', '2019-12-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Tyrel R. King';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2019-12-29', 'exact', '2025-08-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eric N. Shegrud';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2019-12-29', 'exact', '2025-08-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance R. Gilbert';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2019-12-29', 'exact', '2022-03-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trent K. Hodgson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2022-03-20', 'exact', '2025-08-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Anthony S. Vance';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2025-08-24', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jordan B. Livingston';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2025-08-24', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trent B. Barker';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2025-08-24', 'exact', NULL, NULL, 'Current');

    -- Bountiful 25th Ward
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Bountiful 25th Ward';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alvin Kieffer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1963-12-15', 'exact', '1967-03-26', 'exact', 'Organized from Bountiful 14th Ward 15 December 1963');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William Robert McConkie';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1963-12-15', 'exact', '1965-10-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard S. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1965-10-17', 'exact', '1967-03-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard S. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1963-12-15', 'exact', '1965-10-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Barrie G. McKay';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1965-10-17', 'exact', '1967-03-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ray L. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1967-03-26', 'exact', '1971-01-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ralph E. Angerbauer';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1967-03-26', 'exact', '1970-10-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marlow J. Young';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1970-10-25', 'exact', '1971-01-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Herbert F. Hoehne';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1967-03-26', 'exact', '1969-04-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas B. Eggett';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1969-04-27', 'exact', '1970-04-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth G. Hansen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1970-04-19', 'exact', '1971-01-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth G. Hansen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1971-01-24', 'exact', '1977-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marlow J. Young';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1971-01-24', 'exact', '1976-04-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Stephen M. Hadley';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1976-04-18', 'exact', '1977-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vern N. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1971-01-24', 'exact', '1976-04-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Flynn';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1976-04-18', 'exact', '1977-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Stephen M. Hadley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-01-09', 'exact', '1982-01-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Flynn';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-01-09', 'exact', '1977-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brian O. Casper';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-09-11', 'exact', '1981-03-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'V. Lloyd Haynie';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1981-03-15', 'exact', '1982-01-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brian O. Casper';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-01-09', 'exact', '1977-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'V. Lloyd Haynie';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-09-11', 'exact', '1981-03-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer R. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1981-03-15', 'exact', '1982-01-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Barrie G. McKay';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1982-01-31', 'exact', '1986-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Thomas Crosby';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1982-01-31', 'exact', '1986-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David E. Larsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1982-01-31', 'exact', '1986-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lothair W. Thompson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1986-11-16', 'exact', '1991-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary L. Pedersen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1986-11-16', 'exact', '1991-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Phillip D. Houghton';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1986-11-16', 'exact', '1991-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer R. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1991-09-15', 'exact', '1997-02-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'H. Mifflin Williams III';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1991-09-15', 'exact', '1997-02-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William T. Terry';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1991-09-15', 'exact', '1997-02-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'H. Mifflin Williams III';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1997-02-09', 'exact', '2002-07-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew F. Nelson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1997-02-09', 'exact', '2001-05-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Austin R. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2001-05-27', 'exact', '2002-07-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J.D. Packard';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1997-02-09', 'exact', '2001-05-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Scott Erskine';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2001-05-27', 'exact', '2002-07-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Donald L. Showalter III';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2002-07-21', 'exact', '2007-02-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Austin R. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2002-07-21', 'exact', '2004-03-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Doyle L. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2004-03-21', 'exact', '2007-02-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Doyle L. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2002-07-21', 'exact', '2004-03-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bruce T. Davis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2004-03-21', 'exact', '2007-02-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Austin R. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2007-02-04', 'exact', '2012-02-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Toby N. Hawkins';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2007-02-04', 'exact', '2012-02-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Andrew R. Fry';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2007-02-04', 'exact', '2011-06-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven L. Thueson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2011-06-19', 'exact', '2012-02-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven L. Thueson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2012-02-26', 'exact', '2017-03-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kelly M. Barnett';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2012-02-26', 'exact', '2015-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Tyson C. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2015-09-20', 'exact', '2017-03-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael R. Seegmiller';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2012-02-26', 'exact', '2014-12-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Tyson C. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2014-12-07', 'exact', '2015-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'S. Brantz Gentry';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2015-09-20', 'exact', '2017-03-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael R. Seegmiller';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2017-03-12', 'exact', '2022-04-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'S. Brantz Gentry';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2017-03-12', 'exact', '2020-02-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Martin D. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2020-02-02', 'exact', '2022-04-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew R. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2017-03-12', 'exact', '2018-08-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Martin D. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2018-08-26', 'exact', '2020-02-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Simeon J. Wolfgramm';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2020-02-02', 'exact', '2022-04-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kelly M. Barnett';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2022-04-10', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Broderick V. Buttars';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2022-04-10', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael W. Showalter';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2022-04-10', 'exact', NULL, NULL, 'Current');

    -- Bountiful 36th Ward
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Bountiful 36th Ward';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vernon Y. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1968-09-08', 'exact', '1973-03-18', 'exact', 'Organized from Bountiful 4th 7th and 20th wards 8 September 1968');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert M. Horner';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1968-09-08', 'exact', '1973-03-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bryce W. Memmott';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1968-09-08', 'exact', '1973-03-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David B. Walch';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1973-03-18', 'exact', '1974-06-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'T. Richard Downard';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1973-03-18', 'exact', '1974-06-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kent W. Hood';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1973-03-18', 'exact', '1974-06-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'T. Richard Downard';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1974-06-30', 'exact', '1977-01-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ralph A. Watt';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1974-06-30', 'exact', '1975-04-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kent W. Hood';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1975-04-27', 'exact', '1977-01-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kent W. Hood';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1974-06-30', 'exact', '1975-04-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clark M. Mower';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1975-04-27', 'exact', '1977-01-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark M. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-01-16', 'exact', '1981-10-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clark M. Mower';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-01-16', 'exact', '1980-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eugene J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1980-03-16', 'exact', '1981-10-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eugene J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1977-01-16', 'exact', '1980-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David C. Bradford';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1980-03-16', 'exact', '1981-10-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eugene J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1981-10-18', 'exact', '1986-06-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eugene A. Peresich III';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1981-10-18', 'exact', '1986-06-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David L. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1981-10-18', 'exact', '1986-06-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kent W. Hood';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1986-06-08', 'exact', '1989-06-07', 'exact', 'Died in office');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Charles R. Hughes Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1986-06-08', 'exact', '1987-10-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake K. Wade';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1987-10-11', 'exact', '1989-06-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake K. Wade';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1986-06-08', 'exact', '1987-10-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Valentine J. Munoz Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1987-10-11', 'exact', '1989-06-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Elvon L. Bay';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1989-06-11', 'exact', '1991-06-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake K. Wade';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1989-06-11', 'exact', '1990-03-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lester B. Lee';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1990-03-18', 'exact', '1991-06-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lester B. Lee';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1989-06-11', 'exact', '1990-03-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J.A. Guy Dugal';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1990-03-18', 'exact', '1991-06-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hal R. Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1991-06-09', 'exact', '1996-07-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lester B. Lee';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1991-06-09', 'exact', '1993-05-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J.A. Guy Dugal';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1993-05-30', 'exact', '1994-04-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Walter Scott Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1994-04-17', 'exact', '1996-07-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J.A. Guy Dugal';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1991-06-09', 'exact', '1993-05-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Walter Scott Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1993-05-30', 'exact', '1994-04-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sheral V. Karren';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1994-04-17', 'exact', '1996-07-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bryce W. Memmott';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1996-07-14', 'exact', '2000-08-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard F. Reeder';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1996-07-14', 'exact', '2000-08-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vincent K. Humphries';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1996-07-14', 'exact', '2000-08-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wendell N. Moon';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2000-08-20', 'exact', '2005-08-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kay B. Cleverly';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2000-08-20', 'exact', '2005-08-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake W. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2000-08-20', 'exact', '2005-08-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vincent K. Humphries';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2005-08-28', 'exact', '2010-11-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jerry S. Barker';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2005-08-28', 'exact', '2009-03-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Margetts';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2009-03-15', 'exact', '2010-11-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Margetts';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2005-08-28', 'exact', '2009-03-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gordon L. Fisher';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2009-03-15', 'exact', '2010-11-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jerry S. Barker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2010-11-21', 'exact', '2016-02-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Randy S. Beyer';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2010-11-21', 'exact', '2014-11-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Lott';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2014-11-09', 'exact', '2016-02-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan P. Ostler';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2010-11-21', 'exact', '2014-11-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Bret Holbrook';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2014-11-09', 'exact', '2016-02-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake W. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2016-02-07', 'exact', '2017-09-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Lott';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2016-02-07', 'exact', '2017-09-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Bret Holbrook';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2016-02-07', 'exact', '2017-09-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Margetts';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2017-09-17', 'exact', '2022-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Denis B. Longhurst';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2017-09-17', 'exact', '2020-12-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kirk P. Thomas';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2017-09-17', 'exact', '2020-12-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kirk P. Thomas';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2020-12-06', 'exact', '2022-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Robert McLaughlin';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2020-12-06', 'exact', '2022-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jason A. Wendel';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2022-09-11', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Robert McLaughlin';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2022-09-11', 'exact', '2025-10-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Nathan D. Rogers';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2022-09-11', 'exact', '2025-10-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jason W. Baxter';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2025-10-12', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Apollo D. Moser';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2025-10-12', 'exact', NULL, NULL, 'Current');

    -- Bountiful 39th Ward
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Bountiful 39th Ward';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dwight J. Williams';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1970-10-25', 'exact', '1975-05-25', 'exact', 'Organized from Bountiful 14th and 25th wards 25 October 1970');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman T. Marchant';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1970-10-25', 'exact', '1975-05-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lee W. Moss';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1970-10-25', 'exact', '1975-05-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard S. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1975-05-25', 'exact', '1980-08-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ralph E. Angerbauer';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1975-05-25', 'exact', '1980-08-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bernell W. Coons';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1975-05-25', 'exact', '1980-08-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Duane K. Orchard';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1980-08-10', 'exact', '1983-12-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ray B. Tolman';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1980-08-10', 'exact', '1983-12-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John A. Wood';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1980-08-10', 'exact', '1983-12-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ray B. Tolman';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1983-12-11', 'exact', '1988-08-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vance H. Walker';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1983-12-11', 'exact', '1988-08-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Duane Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1983-12-11', 'exact', '1988-08-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joseph C. Rust';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1988-08-14', 'exact', '1994-02-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'N. James Cole';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1988-08-14', 'exact', '1994-02-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dennis P. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1988-08-14', 'exact', '1992-09-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Roy S. Passey';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1992-09-06', 'exact', '1994-02-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Max D. Wallace';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1994-02-13', 'exact', '1998-02-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Duane Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1994-02-13', 'exact', '1995-12-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LaMont V. Fowler';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1995-12-17', 'exact', '1998-02-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LaMont V. Fowler';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1994-02-13', 'exact', '1995-12-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Scott G. Lemon';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1995-12-17', 'exact', '1998-02-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LaMont V. Fowler';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1998-02-15', 'exact', '2004-04-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Scott G. Lemon';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1998-02-15', 'exact', '2000-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard A. Page';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '2000-06-04', 'exact', '2004-04-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard A. Page';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1998-02-15', 'exact', '2000-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Cary A. Lowe';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '2000-06-04', 'exact', '2004-04-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vance H. Walker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2004-04-18', 'exact', '2007-03-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Cary A. Lowe';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2004-04-18', 'exact', '2007-03-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert M. Wilkes Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2004-04-18', 'exact', '2005-07-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeffery A. Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2005-07-24', 'exact', '2007-03-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeffery A. Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2007-03-25', 'exact', '2012-08-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Todd H. Campbell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2007-03-25', 'exact', '2012-08-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ryan D. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2007-03-25', 'exact', '2012-08-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Scott G. Lemon';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2012-08-05', 'exact', '2017-09-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Kent Galloway';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2012-08-05', 'exact', '2015-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David R. Hall';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2015-09-20', 'exact', '2017-09-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wells V. Wilkinson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2012-08-05', 'exact', '2015-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Christopher M. Jenkins';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2015-09-20', 'exact', '2017-09-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wells V. Wilkinson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2017-09-24', 'exact', '2022-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Christopher M. Jenkins';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2017-09-24', 'exact', '2021-08-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brian L. Black';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2017-09-24', 'exact', '2021-08-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brian L. Black';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2021-08-15', 'exact', '2022-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Samuel J. Bawden';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2021-08-15', 'exact', '2022-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Christopher M. Jenkins';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2022-09-25', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary B. Neilson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2022-09-25', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joshua E. Pay';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2022-09-25', 'exact', NULL, NULL, 'Current');

    -- Bountiful 4th Ward
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Bountiful 4th Ward';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Vincent Ord';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1945-10-18', 'exact', '1952-03-16', 'exact', 'Organized from Bountiful 2nd Ward 18 Oct 1945');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Neil W. Kooyman';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1945-10-18', 'exact', '1948-01-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'L. Woodruff Stout';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1948-01-18', 'exact', '1952-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'L. Woodruff Stout';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1945-10-18', 'exact', '1948-01-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Wayne Mason';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1948-01-18', 'exact', '1952-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Calvin P. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1952-03-16', 'exact', '1956-09-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wayne M. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1952-03-16', 'exact', '1956-09-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clifton I. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1952-03-16', 'exact', '1956-04-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William A. Hoagland';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1956-04-22', 'exact', '1956-09-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William A. Hoagland';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1956-09-23', 'exact', '1961-04-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vern N. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1956-09-23', 'exact', '1961-04-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hal R. Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1956-09-23', 'exact', '1960-07-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vernon Y. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1960-07-31', 'exact', '1961-04-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clifton I. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1961-04-30', 'exact', '1969-05-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert G. Irvine';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1961-04-30', 'exact', '1968-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lyle N. Cole';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1968-09-08', 'exact', '1969-05-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary P. Cox';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1961-04-30', 'exact', '1967-05-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lyle N. Cole';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1967-05-21', 'exact', '1968-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Courtney L. Childs';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1968-09-08', 'exact', '1969-05-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lyle N. Cole';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1969-05-18', 'exact', '1971-01-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Claude L. Mills';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1969-05-18', 'exact', '1971-01-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie M. Atkinson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1969-05-18', 'exact', '1969-09-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James M. Irvine';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1969-09-21', 'exact', '1971-01-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'F. Burton Howard';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1971-01-03', 'exact', '1971-01-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Percy W. Pratt';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1971-01-03', 'exact', '1971-01-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = '(None called)';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '', 'exact', NULL, NULL, 'No 2nd counselor called');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert A. Gelder';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1971-01-24', 'exact', '1978-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Percy W. Pratt';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1971-01-24', 'exact', '1974-07-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harvey L. Padley';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1974-07-28', 'exact', '1976-07-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ted F. Powell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1976-07-25', 'exact', '1977-01-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman G. Ainscough';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1977-01-30', 'exact', '1978-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harvey L. Padley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1971-01-24', 'exact', '1974-07-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ted F. Powell';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1974-07-28', 'exact', '1976-07-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman G. Ainscough';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1976-07-25', 'exact', '1977-01-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie T. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1977-01-30', 'exact', '1978-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary L. Wall';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1978-06-11', 'exact', '1983-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie T. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1978-06-11', 'exact', '1982-11-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry A. Carter';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1982-11-21', 'exact', '1983-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry A. Carter';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1978-06-11', 'exact', '1982-11-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Buddy K. Funk';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1982-11-21', 'exact', '1983-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'F. Michael Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1983-06-12', 'exact', '1986-11-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl G. Jones';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1983-06-12', 'exact', '1985-03-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Buddy K. Funk';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1985-03-31', 'exact', '1986-11-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Buddy K. Funk';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1983-06-12', 'exact', '1985-03-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David B. Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1985-03-31', 'exact', '1986-01-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry E. Fuller';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1986-01-26', 'exact', '1986-11-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry E. Fuller';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1986-11-30', 'exact', '1991-08-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harold K. Smith';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1986-11-30', 'exact', '1991-08-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Thomas V. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1986-11-30', 'exact', '1990-06-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'G. Tod Moss';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1990-06-17', 'exact', '1991-08-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie T. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1991-08-11', 'exact', '1994-08-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Edward W. Ancell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1991-08-11', 'exact', '1992-01-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ardel K. Moffett';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1992-01-12', 'exact', '1994-08-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ardel K. Moffett';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1991-08-11', 'exact', '1992-01-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clark Richardson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1992-01-12', 'exact', '1994-08-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'G. Tod Moss';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1994-08-28', 'exact', '1999-08-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman G. Ainscough';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1994-08-28', 'exact', '1995-07-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen R. Simmons';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1995-07-23', 'exact', '1999-08-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eric G. Eddings';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1994-08-28', 'exact', '1995-07-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Stephen G. Carter';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1995-07-23', 'exact', '1999-08-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sterling G. Umphenour Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1999-08-29', 'exact', '2003-02-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dwayne S. McOmie';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1999-08-29', 'exact', '2003-02-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kelly B. Parsons';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1999-08-29', 'exact', '2003-02-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Thomas V. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2003-02-16', 'exact', '2008-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bert L. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2003-02-16', 'exact', '2006-01-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard G. Reeder';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2006-01-08', 'exact', '2008-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brent M. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2003-02-16', 'exact', '2006-01-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brett M. Pattison';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2006-01-08', 'exact', '2008-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brent M. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2008-11-16', 'exact', '2014-08-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven R. Merkley';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2008-11-16', 'exact', '2012-09-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Duane R. Harrison';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2012-09-30', 'exact', '2014-08-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Duane R. Harrison';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2008-11-16', 'exact', '2012-09-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Thomas Woodland';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2012-10-21', 'exact', '2014-08-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary R. Hill';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2014-08-03', 'exact', '2019-08-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Thomas Woodland';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2014-08-03', 'exact', '2017-01-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Roger G. Shumway Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2017-01-29', 'exact', '2019-08-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Roger G. Shumway Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2014-08-03', 'exact', '2017-01-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kyle W. Dimond';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2017-01-29', 'exact', '2019-08-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Roger G. Shumway Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2019-08-18', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael L. Van Dam';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2019-08-18', 'exact', '2020-09-20', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer D. Arntsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2019-08-18', 'exact', '2020-09-20', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer D. Arntsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2020-09-20', 'exact', '2023-11-26', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Allen N. Whipple';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2020-09-20', 'exact', '2023-11-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Allen N. Whipple';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2023-11-26', 'exact', NULL, NULL, 'Handwritten - Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kirk R. Stephens';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2023-11-26', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David A. Orson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2023-11-26', 'exact', '2024-06-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gregory R. Misener';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2024-06-16', 'exact', NULL, NULL, 'Current');

    -- Bountiful 57th Ward
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Bountiful 57th Ward';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vern N. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1983-01-30', 'exact', '1986-02-16', 'exact', 'Singles Ward - Organized 30 January 1983 drawing single members from other wards in the stake and from outside the stake');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Rodney Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1983-01-30', 'exact', '1985-07-14', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hal R. Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1985-07-14', 'exact', '1986-02-16', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David G. Angerbauer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1983-01-30', 'exact', '1985-07-14', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard S. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1985-07-14', 'exact', '1986-02-16', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hal R. Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1986-02-16', 'exact', '1989-02-19', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard S. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1986-02-16', 'exact', '1989-02-19', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Herbert E. Broughton';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1986-02-16', 'exact', '1989-02-19', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Buddy K. Funk';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1989-02-19', 'exact', '1992-03-15', 'exact', 'Singles Ward - Discontinued 15 March 1992 due to decrease in membership');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'K. Glen McArthur';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1989-02-19', 'exact', '1990-02-18', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ronald Romney';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1990-02-18', 'exact', '1992-03-15', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ronald Romney';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1989-02-19', 'exact', '1990-02-18', 'exact', 'Singles Ward');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'A. Boyd Hansen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1990-02-18', 'exact', '1992-03-15', 'exact', 'Singles Ward - Ward discontinued');

    -- Bountiful 7th Ward
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Bountiful 7th Ward';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sterling E. Beesley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1952-03-16', 'exact', '1955-06-12', 'exact', 'Organized from Bountiful 4th Ward 16 March 1952');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'M. Newell Tingey';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1952-03-16', 'exact', '1952-03-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Percy E. Burrup';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1952-03-30', 'exact', '1952-09-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Odell Dale Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1952-09-14', 'exact', '1955-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Percy E. Burrup';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1952-03-16', 'exact', '1952-03-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Odell Dale Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1952-03-30', 'exact', '1952-09-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Barryington T. Wride';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1952-09-14', 'exact', '1955-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Barryington T. Wride';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1955-06-12', 'exact', '1962-07-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gordon L. Carlson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1955-06-12', 'exact', '1960-07-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Dean Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-07-31', 'exact', '1960-12-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ned M. Vowles';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-12-25', 'exact', '1962-07-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David A. Russell';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1955-06-12', 'exact', '1956-12-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Dean Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1956-12-30', 'exact', '1960-07-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ned M. Vowles';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-07-31', 'exact', '1960-12-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ivan O. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-12-25', 'exact', '1962-07-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Durant Thompson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1962-07-29', 'exact', '1966-05-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard Tingey';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1962-07-29', 'exact', '1966-05-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Rodney Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1962-07-29', 'exact', '1966-05-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'F. Burton Howard';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1966-05-15', 'exact', '1971-01-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harl M. Noble';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1966-05-15', 'exact', '1968-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ralph A. Watt';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1968-09-08', 'exact', '1969-01-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Melvin H. Robins';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1969-01-19', 'exact', '1971-01-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ralph A. Watt';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1966-05-15', 'exact', '1968-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Melvin H. Robins';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1968-09-08', 'exact', '1969-01-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Percy W. Pratt';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1969-01-19', 'exact', '1971-01-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lyle N. Cole';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1971-01-03', 'exact', '1972-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Claude L. Mills';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1971-01-03', 'exact', '1972-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James M. Irvine';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1971-01-03', 'exact', '1972-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Milton K. Shaum';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1972-06-04', 'exact', '1979-01-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lyle S. Hintze';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1972-06-04', 'exact', '1979-01-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael L. Verkler';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1972-06-04', 'exact', '1974-06-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl D. Winger';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1974-06-23', 'exact', '1979-01-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Phillip R. Barber';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1979-01-14', 'exact', '1983-12-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Stanley Elmer';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1979-01-14', 'exact', '1983-12-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Melvin J. Ericksen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1979-01-14', 'exact', '1983-12-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Benjamin I. Martinez';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1983-12-18', 'exact', '1986-06-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Craige J. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1983-12-18', 'exact', '1986-06-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Richard Hanson Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1983-12-18', 'exact', '1986-06-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Stanley Elmer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1986-06-22', 'exact', '1990-02-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Craige J. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1986-06-22', 'exact', '1987-07-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James R. Lynch';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1987-07-19', 'exact', '1988-10-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jon L. Ringwood';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1988-10-09', 'exact', '1990-02-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Richard Hanson Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1986-06-22', 'exact', '1987-07-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith W. Schoenfeld';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1987-07-19', 'exact', '1988-10-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David K. Balling';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1988-10-09', 'exact', '1990-02-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John W. Haacke';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1990-02-25', 'exact', '1995-01-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jon L. Ringwood';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1990-02-25', 'exact', '1992-07-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leon D. Lundquist';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1992-07-19', 'exact', '1995-01-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David K. Balling';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1990-02-25', 'exact', '1990-06-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Stanley P. Ferguson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1990-06-10', 'exact', '1995-01-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Craige J. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1995-01-23', 'exact', '2000-05-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James C. Burns';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1995-01-23', 'exact', '2000-05-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Frank J. Sano';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1995-01-23', 'exact', '1996-11-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Richard Hanson Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1996-11-17', 'exact', '2000-05-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wesley E. White';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2000-05-28', 'exact', '2005-08-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn D. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2000-05-28', 'exact', '2005-08-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Todd Wesche';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '2000-05-28', 'exact', '2005-08-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert S. Lee';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2005-08-21', 'exact', '2010-06-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Randy F. Jackson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2005-08-21', 'exact', '2009-03-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Henry A. Mora';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2009-03-29', 'exact', '2010-06-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joshua S. Grimstead';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2005-08-21', 'exact', '2009-03-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brady S. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2009-03-29', 'exact', '2010-06-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Richard Hanson Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2010-06-27', 'exact', '2015-07-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Craige J. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2010-06-27', 'exact', '2015-07-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brady S. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2010-06-27', 'exact', '2012-06-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeremy R. Holt';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2012-06-10', 'exact', '2015-07-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joshua S. Grimstead';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2015-07-12', 'exact', '2020-10-25', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Craig L. Randall';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2015-07-12', 'exact', '2017-03-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jesse D. Bell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2017-03-12', 'exact', '2018-02-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brooke L. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2018-02-25', 'exact', '2020-10-25', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jesse D. Bell';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2015-07-12', 'exact', '2017-03-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas W. Osborn';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2017-03-12', 'exact', '2018-02-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glenn A. Register';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2018-02-25', 'exact', '2020-10-25', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clark B. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2020-10-25', 'exact', '2025-11-16', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brandon T. Toone';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2020-10-25', 'exact', '2025-11-16', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marc B. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2020-10-25', 'exact', '2021-04-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James A. Burns';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2021-04-25', 'exact', '2025-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brooke L. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Bishop';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2025-11-16', 'exact', NULL, NULL, 'Handwritten - Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glenn A. Register';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2025-11-16', 'exact', NULL, NULL, 'Handwritten - Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jason J. Steenblik';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2025-11-16', 'exact', NULL, NULL, 'Handwritten - Current');

    -- Heritage Branch
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Heritage Branch';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert D. Todd';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1992-04-12', 'exact', '1996-03-31', 'exact', 'Organized from Bountiful 7th Ward 12 April 1992 to serve residents of Heritage Place retirement center');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde W. Willey';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1992-04-12', 'exact', '1996-03-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Doyle P. Shurtz';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1992-04-12', 'exact', '1993-10-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vern N. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1993-10-31', 'exact', '1996-03-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vern N. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1996-03-31', 'exact', '1998-11-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde C. Page';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1996-03-31', 'exact', '1998-11-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard P. Stapley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1996-03-31', 'exact', '1998-11-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde C. Page';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1998-11-17', 'exact', '2003-04-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard P. Stapley';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1998-11-17', 'exact', '2003-04-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Weldon M. Egbert';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1998-11-17', 'exact', '2003-04-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard M. Downward';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '2003-04-27', 'exact', '2006-07-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sterling G. Umphenour Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '2003-04-27', 'exact', '2006-07-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven L. Brown';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '2003-04-27', 'exact', '2006-07-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'G. Ernest Deters';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '2006-07-02', 'exact', '2009-07-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen G. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '2006-07-02', 'exact', '2008-02-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'George Allan';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '2008-02-24', 'exact', '2009-07-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'George Allan';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '2006-07-02', 'exact', '2008-02-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Stanley Elmer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '2008-02-24', 'exact', '2009-07-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lothair W. Thompson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '2009-07-19', 'exact', '2012-08-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eugene M. Hamilton';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '2009-07-19', 'exact', '2011-05-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Doyle L. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '2011-05-29', 'exact', '2012-08-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Doyle L. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '2009-07-19', 'exact', '2011-05-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry E. Fuller';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '2011-05-29', 'exact', '2012-08-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen R. Simmons';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '2012-08-26', 'exact', '2014-11-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Paul Millburn';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '2012-08-26', 'exact', '2014-11-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delbert H. Strasser';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '2012-08-26', 'exact', '2014-11-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert W. Jeppsen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2014-11-09', 'exact', '2018-03-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jay A. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2014-11-09', 'exact', '2018-03-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Max T. Kieffer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2014-11-09', 'exact', '2018-03-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William T. Terry';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2018-03-11', 'exact', '2022-02-06', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven E. Joy';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2018-03-11', 'exact', '2022-02-06', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'M. Neil Cleverly';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2018-03-11', 'exact', '2022-02-06', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeffery K. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2022-02-06', 'exact', '2025-06-22', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hyde H. Frederickson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2022-02-06', 'exact', '2025-06-22', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth P. Schwab';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '2022-02-06', 'exact', '2025-06-22', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan P. Ostler';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Branch President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2025-06-22', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Bret Holbrook';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2025-06-22', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Scott Allred';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '2025-06-22', 'exact', NULL, NULL, 'Current');

    -- High Council
    SELECT id INTO v_org_id FROM organizations WHERE name = 'High Council';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sterling E. Beesley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1962-09-30', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde W. Mills';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1958-10-05', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Calvin P. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1967-10-08', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Durant Thompson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1962-09-30', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Drexel Beckman';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1961-03-19', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Vincent Ord';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1967-10-08', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Austin F. Whitmer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1961-01-08', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Floyd D. Rasmussen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1964-05-31', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Orval Hayes';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1967-10-08', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John M. Powell';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1964-05-31', 'exact', 'Holbrook Presidency; died 13 Apr 1964');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Elmo J. Steed';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1967-10-08', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William L. Page';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-06-08', 'exact', '1967-10-08', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Frank Craven';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-10-05', 'exact', '1967-10-08', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth C. Pendleton';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1961-01-08', 'exact', '1967-10-08', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Donald E. Rose';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1961-01-08', 'exact', '1974-01-02', 'year', 'Holbrook Presidency; alternate till 19 Mar 1961; died in office');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jay R. Bingham';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1961-03-19', 'exact', '1964-05-31', 'exact', 'Holbrook Presidency; alternate till 30 Sep 1962');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wayne M. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1962-09-30', 'exact', '1963-09-29', 'exact', 'Holbrook Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Bruce Smart';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1962-09-30', 'exact', '1964-10-19', 'exact', 'Holbrook Presidency; alternate till 29 Sep 1963');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ivan O. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1962-09-30', 'exact', '1971-01-10', 'exact', 'Holbrook Presidency; alternate till 31 May 1964');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'C. Evan Moss';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1963-09-29', 'exact', '1969-06-01', 'exact', 'Holbrook Presidency; alternate till 31 May 1964');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard G. Sharp';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1964-05-31', 'exact', '1971-01-10', 'exact', 'Hayes Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vern N. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1964-05-31', 'exact', '1971-01-10', 'exact', 'Hayes Presidency; alternate till 10 Jan 1965');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vernon Y. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1964-05-31', 'exact', '1968-09-29', 'exact', 'Hayes Presidency; alternate till 8 Oct 1967');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard S. Prows';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-06-04', 'exact', '1971-01-10', 'exact', 'Hayes Presidency; alternate till 8 Oct 1967');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ned M. Vowles';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-10-08', 'exact', '1973-09-30', 'exact', 'Hayes Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen G. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-10-08', 'exact', '1972-10-01', 'exact', 'Hayes Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Barrie G. McKay';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-10-08', 'exact', '1971-01-10', 'exact', 'Hayes Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Newell J. Bryson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-10-08', 'exact', '1971-01-10', 'exact', 'Hayes Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard G. Southwick';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-10-08', 'exact', '1970-05-31', 'exact', 'Hayes Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clifford H. Poulsen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-10-08', 'exact', '1971-01-10', 'exact', 'Hayes Presidency; alternate till 29 Sep 1968');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Eberhard Sommer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1967-10-08', 'exact', '1972-06-04', 'exact', 'Hayes Presidency; alternate till 1 Jun 1969');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Morris F. Swapp';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1968-09-29', 'exact', '1972-06-04', 'exact', 'Hayes Presidency; alternate till 31 May 1970');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Merrill W. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1969-09-28', 'exact', '1971-01-10', 'exact', 'Hayes Presidency; alternate entire time');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Layton P. Ott';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1970-05-31', 'exact', '1971-01-10', 'exact', 'Hayes Presidency; alternate entire time');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Melvin H. Robins';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-01-10', 'exact', '1976-01-11', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dennis C. Winter';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-01-10', 'exact', '1976-03-21', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John L. White';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-03-21', 'exact', '1975-05-31', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William A. Hoagland';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-03-21', 'exact', '1975-05-31', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Rodney Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-03-21', 'exact', '1976-03-21', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard S. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-03-21', 'exact', '1975-05-31', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Stephen M. Hadley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-03-21', 'exact', '1976-03-21', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harl M. Noble';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1972-03-19', 'exact', '1979-03-25', 'exact', 'Howard Presidency; alternate till 4 Jun 1972');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Floyd E. Trimble';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1972-06-04', 'exact', '1977-06-12', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hal R. Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1972-06-04', 'exact', '1978-10-15', 'exact', 'Howard Presidency; alternate till 1 Oct 1972');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn E. Zabriskie';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1973-09-30', 'exact', '1977-06-12', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl G. Jones';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1974-02-02', 'exact', '1982-03-07', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ralph E. Angerbauer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1974-05-04', 'exact', '1975-05-31', 'exact', 'Howard Presidency; alternate entire time');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gerald N. Wray';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1975-05-31', 'exact', '1978-10-15', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary L. Wall';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1975-05-31', 'exact', '1977-06-12', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'H. Mifflin Williams III';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1975-05-31', 'exact', '1981-03-01', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James C. Burns';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1975-09-28', 'exact', '1977-10-16', 'exact', 'Howard Presidency; alternate till 21 Mar 1976');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dwight J. Williams';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1976-01-11', 'exact', '1979-10-14', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn D. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1976-03-21', 'exact', '1977-06-12', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Max B. Welcker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1976-03-21', 'exact', '1980-08-02', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth G. Toone';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1976-03-21', 'exact', '1977-06-12', 'exact', 'Howard Presidency; alternate entire time');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen G. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1977-06-12', 'exact', '1982-03-07', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth G. Hansen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1977-06-12', 'exact', '1982-03-07', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Henry A. Haurand';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1977-06-12', 'exact', '1980-03-23', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'DeVor Moss';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1977-06-12', 'exact', '1978-03-26', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth G. Toone';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1977-10-16', 'exact', '1982-03-07', 'exact', 'Howard Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James A. Collier';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1978-03-26', 'exact', '1980-03-23', 'exact', 'Howard Presidency; died 7 Jan 1980');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joseph C. Rust';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1978-10-15', 'exact', '1983-09-25', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kent W. Hood';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1978-10-15', 'exact', '1982-09-26', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jay Livingood';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1979-01-06', 'exact', '1984-03-04', 'exact', 'Wray Presidency; alternate till 25 Mar 1979');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert J. Little';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1979-02-03', 'exact', '1985-09-02', 'exact', 'Wray Presidency; alternate till 14 Oct 1979');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Milton K. Shaum';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1979-10-14', 'exact', '1985-09-22', 'exact', 'Wray Presidency; alternate till 23 Mar 1980');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Miles I. Miller';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1980-03-23', 'exact', '1985-09-22', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Rex L. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1980-03-23', 'exact', '1981-09-20', 'exact', 'Wray Presidency; alternate till 2 Aug 1980');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Donald West';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1980-08-02', 'exact', '1987-03-01', 'exact', 'Wray Presidency; alternate till 1 Mar 1981');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brian O. Casper';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1981-03-01', 'exact', '1986-09-21', 'exact', 'Wray Presidency; alternate till 20 Sep 1981');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Boyd V. Rydalch';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1981-09-20', 'exact', '1985-03-03', 'exact', 'Wray Presidency; alternate till 7 Mar 1982');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark M. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1981-09-20', 'exact', '1987-09-20', 'exact', 'Wray Presidency; alternate till 7 Mar 1982');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer R. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1982-03-07', 'exact', '1985-09-22', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn D. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1982-03-07', 'exact', '1982-09-26', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Benjamin I. Martinez';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1982-03-07', 'exact', '1984-03-04', 'exact', 'Wray Presidency; alternate till 26 Sep 1982');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harold K. Smith';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1982-03-07', 'exact', '1986-03-02', 'exact', 'Wray Presidency; alternate till 26 Sep 1982');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl D. Winger';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1982-09-26', 'exact', '1987-09-20', 'exact', 'Wray Presidency; alternate till 25 Sep 1983');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen T. Campbell';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1982-09-26', 'exact', '1986-09-21', 'exact', 'Wray Presidency; alternate till 4 Mar 1984');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vance H. Walker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1983-09-25', 'exact', '1984-03-04', 'exact', 'Wray Presidency; alternate entire time');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde C. Page';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1983-01-01', 'year', '1985-09-22', 'exact', 'Wray Presidency; alternate till 4 Mar 1984; sustained late 1983');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'A. Dee Moultrie';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1985-03-03', 'exact', '1988-09-25', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'K. Glen McArthur';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1985-09-22', 'exact', '1989-03-05', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ronald Romney';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1985-09-22', 'exact', '1987-09-20', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Stanley Elmer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1985-09-22', 'exact', '1986-09-21', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Paul Millburn';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1985-09-22', 'exact', '1988-09-25', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lothair W. Thompson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1985-09-22', 'exact', '1987-03-01', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie T. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1986-03-02', 'exact', '1991-03-03', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eugene J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1986-09-21', 'exact', '1991-09-22', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Rex L. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1986-09-21', 'exact', '1987-09-20', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ariel A. Hulse';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1986-09-21', 'exact', '1988-09-25', 'exact', 'Wray Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David E. Larsen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1987-03-01', 'exact', '1993-09-26', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dean B. Cleverly';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1987-03-01', 'exact', '1990-06-17', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hyrum B. Nay';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1987-09-20', 'exact', '1989-03-05', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven L. Brown';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1987-09-20', 'exact', '1992-09-20', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Charles R. Hughes Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1987-09-20', 'exact', '1990-06-17', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Phillip R. Barber';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1987-09-20', 'exact', '1989-10-15', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'V. Lloyd Haynie';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1988-09-25', 'exact', '1993-09-26', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard J. Lawrence';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1988-09-25', 'exact', '1992-09-20', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Roger D. Phillips';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1988-09-25', 'exact', '1991-03-03', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael W. Crippen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1989-03-05', 'exact', '1991-06-23', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Herbert E. Broughton';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1989-03-05', 'exact', '1992-06-14', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John W. Haacke';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1989-10-15', 'exact', '1990-03-04', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Richard Hanson Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1990-03-04', 'exact', '1994-03-06', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Duane Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1990-06-17', 'exact', '1994-03-06', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gail E. Anger';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1990-06-17', 'exact', '1991-03-03', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harvey L. Padley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1991-03-03', 'exact', '1995-09-10', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde S. St. Clair';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1991-03-03', 'exact', '1995-09-10', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Donald L. Braden';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1991-03-03', 'exact', '1993-03-07', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vance H. Walker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1991-06-23', 'exact', '1996-09-15', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas J. Hammond';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1991-09-22', 'exact', '1992-06-14', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William E. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1992-06-14', 'exact', '1995-06-11', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Clawson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1992-06-14', 'exact', '1994-03-06', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael W. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1992-09-20', 'exact', '1994-03-06', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Eberhard Sommer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1992-09-20', 'exact', '1997-09-07', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard V. Wall';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1993-03-07', 'exact', '1994-09-25', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry E. Fuller';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1993-09-26', 'exact', '1998-03-08', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lothair W. Thompson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1993-09-26', 'exact', '1998-09-13', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bryce W. Memmott';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1994-01-23', 'exact', '1996-08-25', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance L. Wood';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1994-01-23', 'exact', '1996-09-15', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Colin B. Van Orman';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1994-03-06', 'exact', '1994-12-11', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Craige J. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1994-03-06', 'exact', '1995-03-05', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clarence C. Neslen Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1994-09-25', 'exact', '2000-06-04', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bret C. Morgan';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1994-12-11', 'exact', '1996-06-09', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan C. Jacobs';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1995-03-05', 'exact', '2000-06-04', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lester B. Lee';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1995-06-01', 'exact', '1999-03-07', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Stephen M. Hadley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1995-09-10', 'exact', '1996-02-25', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry L. Young';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1995-09-10', 'exact', '1996-02-04', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jan V. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1996-02-04', 'exact', '2002-03-03', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John Gallacher';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1996-02-25', 'exact', '1999-03-07', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wendell R. Fackrell';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1996-06-09', 'exact', '2002-03-03', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Roy S. Passey';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1996-08-25', 'exact', '1999-09-12', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Thomas V. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1996-09-15', 'exact', '2003-03-02', 'exact', 'Watson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kirk R. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1996-09-15', 'exact', '1999-03-07', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Cory F. Hanks';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1997-09-07', 'exact', '1999-06-13', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William T. Terry';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1998-03-08', 'exact', '2003-09-07', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Walter Scott Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1998-09-13', 'exact', '2004-03-07', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark C. Swain';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1999-03-07', 'exact', '2004-03-07', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Shaun D. Stahle';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1999-03-07', 'exact', '2004-03-07', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jerry M. Crawford';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1999-03-07', 'exact', '2004-03-07', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas J. Hammond';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1999-06-13', 'exact', '2001-09-09', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'N. James Cole';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1999-09-12', 'exact', '2005-03-06', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James C. Burns';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2000-06-04', 'exact', '2005-06-12', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Scott G. Lemon';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2000-06-04', 'exact', '2005-06-12', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vincent K. Humphries';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2001-09-09', 'exact', '2005-08-28', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dean B. Cleverly';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2002-03-03', 'exact', '2007-09-09', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew K. Judd';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2002-03-03', 'exact', '2005-03-06', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dwayne S. McOmie';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2003-03-02', 'exact', '2007-09-09', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Scott Erskine';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2003-09-07', 'exact', '2007-09-01', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James B. De Moux';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2004-03-07', 'exact', '2007-09-09', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Fennemore';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2004-03-07', 'exact', '2005-08-28', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Austin R. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2004-03-07', 'exact', '2007-03-04', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael D. Huff';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2004-03-07', 'exact', '2010-09-12', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bret C. Morgan';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-03-06', 'exact', '2005-09-11', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeffery A. Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-03-06', 'exact', '2005-08-28', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'L. Kenneth Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-06-12', 'exact', '2005-09-11', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert S. Lee';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-06-12', 'exact', '2005-08-28', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Cory F. Hanks';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-08-28', 'exact', '2005-09-11', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'G. Ernest Deters';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-08-28', 'exact', '2006-07-23', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Todd Wesche';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-08-28', 'exact', '2010-09-12', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake W. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-08-28', 'exact', '2008-09-07', 'exact', 'Veigel Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bruce E. Barlow';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-09-11', 'exact', '2011-03-06', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John P. Esplin';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-09-11', 'exact', '2008-09-07', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wendell N. Moon';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2005-09-11', 'exact', '2010-05-01', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Kent Galloway';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2006-07-23', 'exact', '2011-09-11', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wesley E. White';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2007-03-04', 'exact', '2007-09-09', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hyde H. Frederickson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2007-09-09', 'exact', '2012-09-16', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bruce T. Davis';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2007-09-09', 'exact', '2012-09-16', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lionel B. Farr';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2007-09-09', 'exact', '2011-11-27', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Duane R. Harrison';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2007-09-09', 'exact', '2009-03-08', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Scott L. Larsen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2007-09-09', 'exact', '2012-09-16', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Thomas L. McLachlan';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2008-09-07', 'exact', '2010-09-12', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sterling L. Barker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2008-09-07', 'exact', '2012-04-08', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jerry S. Barker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2009-03-08', 'exact', '2011-01-16', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary W. Call';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2010-05-01', 'exact', '2010-09-12', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert S. Lee';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2010-09-12', 'exact', '2012-09-16', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew J. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2010-09-12', 'exact', '2011-09-11', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Scott B. Davis';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2010-09-12', 'exact', '2010-11-19', 'exact', 'Hanks Presidency; died while serving');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brandon G. Brown';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2010-09-12', 'exact', '2015-09-13', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Margetts';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2011-01-16', 'exact', '2014-10-26', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael L. Van Dam';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2011-01-16', 'exact', '2016-03-06', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James E. Rushforth';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2011-03-06', 'exact', '2014-04-26', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brian L. Black';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2011-09-11', 'exact', '2016-03-06', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Curtis B. Knudsen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2011-09-11', 'exact', '2015-03-08', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bret G. Dixon';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2011-11-27', 'exact', '2015-04-19', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James L. Florence';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2012-04-08', 'exact', '2017-03-05', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven R. Merkley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2012-09-16', 'exact', '2013-09-08', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Martin D. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2012-09-16', 'exact', '2017-03-05', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eric S. Calder';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2012-09-16', 'exact', '2014-08-31', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Craig L. Randall';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2012-09-16', 'exact', '2015-09-13', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joshua S. Grimstead';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2013-09-08', 'exact', '2015-09-13', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert M. Craven';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2014-04-26', 'exact', '2019-03-03', 'exact', 'Hanks Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary W. Call';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2014-08-31', 'exact', '2019-09-22', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan P. Ostler';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2014-10-26', 'exact', '2020-01-26', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance D. Regis';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2015-03-08', 'exact', '2019-09-22', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Todd H. Campbell';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2015-04-19', 'exact', '2015-09-13', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeffery A. Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2015-09-13', 'exact', '2018-03-04', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kevin R. Knight';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2015-09-13', 'exact', '2016-09-18', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Randy S. Beyer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2015-09-13', 'exact', '2016-05-01', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Paul E. Barlow';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2015-09-13', 'exact', '2020-11-01', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer L. Winegar';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2016-03-06', 'exact', '2016-09-18', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Troy Burnett';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2016-03-06', 'exact', '2017-04-30', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brooke L. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2016-05-01', 'exact', '2018-03-04', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert S. Lee';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2016-09-18', 'exact', '2018-03-04', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jason A. Wendel';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2016-09-18', 'exact', '2020-12-06', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn R. Clement';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2017-03-05', 'exact', '2021-08-29', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Tyson C. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2017-03-05', 'exact', '2021-08-29', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brent M. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2017-04-30', 'exact', '2023-12-03', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Lott';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2018-03-04', 'exact', '2019-03-03', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Esplin';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2018-03-04', 'exact', '2019-03-03', 'exact', 'Anderson Presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Cameron C. Kent';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2018-03-04', 'exact', '2021-08-29', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trevor L. Austin';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2018-09-09', 'exact', '2024-08-18', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven L. Thueson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2019-03-03', 'exact', '2024-03-01', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jesse D. Bell';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2019-03-03', 'exact', '2024-03-01', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clark B. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2019-09-22', 'exact', '2020-11-01', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew C. Murri';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2019-09-22', 'exact', '2023-10-01', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gregory P. Johns';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2020-01-26', 'exact', '2021-08-29', 'exact', 'Anderson Presidency; handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary R. Hill';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2020-11-01', 'exact', '2023-08-27', 'exact', 'Released to become Stake President');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Nathan R. Wuthrich';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2020-11-01', 'exact', '2025-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Denis B. Longhurst';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2020-12-06', 'exact', '2025-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Christopher M. Jenkins';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2021-08-29', 'exact', '2022-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kelly M. Barnett';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2021-08-29', 'exact', '2022-10-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Randy F. Jackson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2021-08-29', 'exact', '2025-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard T. Derr';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2021-08-29', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Simeon J. Wolfgramm';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2022-11-13', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'E. Ryan Miller';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2023-01-29', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Samuel J. Bawden';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2022-10-22', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Roger G. Shumway Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2022-12-03', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeremy R. Holt';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2024-03-03', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Abel M. Chavez Sr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2023-03-03', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Samuel D. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2024-08-18', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Craige J. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2025-09-07', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Aaron M. Coombs';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2025-09-07', 'exact', NULL, NULL, NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer M. Hadley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'High Councilor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2025-09-07', 'exact', NULL, NULL, NULL);

    -- Stake Clerk
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Clerk';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde C. Page';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1961-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harold C. Secrist';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1961-03-19', 'exact', '1965-11-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert A. Gelder';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1965-11-22', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith W. Schoenfeld';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-03-21', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Thomas Crosby';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1981-03-01', 'exact', '1982-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Avon T. Francis';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1982-03-07', 'exact', '1982-09-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ariel A. Hulse';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1982-09-26', 'exact', '1986-09-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William L. Brown';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1986-09-21', 'exact', '1991-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ariel A. Hulse';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1991-09-22', 'exact', '2004-04-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LaMont V. Fowler';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2004-05-25', 'exact', '2011-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew J. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2011-09-11', 'exact', '2014-10-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vincent K. Humphries';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2014-10-12', 'exact', '2020-11-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'E. Ryan Miller';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2020-11-01', 'exact', '2023-01-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven G. Farley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Stake Clerk';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2023-01-08', 'exact', NULL, NULL, 'Current');

    -- Stake Executive Secretary
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Executive Secretary';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'C. Evan Moss';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Executive Secretary';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1969-06-01', 'exact', '1970-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Donald E. Rose';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Executive Secretary';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1970-09-27', 'exact', '1971-01-10', 'exact', 'Served simultaneously as high councilor');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clifton C. Clark';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Executive Secretary';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-01-10', 'exact', '1987-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark M. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Executive Secretary';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1987-09-20', 'exact', '1990-06-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dean B. Cleverly';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Executive Secretary';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1990-06-17', 'exact', '1996-02-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gordon I. Irving';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Executive Secretary';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1996-02-04', 'exact', '2015-03-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Samuel J. Bawden';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Executive Secretary';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2015-03-08', 'exact', '2017-04-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Troy Burnett';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Executive Secretary';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2017-04-16', 'exact', NULL, NULL, 'Current');

    -- Stake Mission
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Mission';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wayne M. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1960-05-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde F. Smith';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1960-05-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Otto Van Ry';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1960-05-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sisson C. Hatch';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-05-15', 'exact', '1963-01-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kay J. Collings';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-05-15', 'exact', '1962-01-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hal R. Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-01-08', 'exact', '1963-01-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Edward W. Ancell';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-05-15', 'exact', '1961-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John H. Mabey';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1961-06-04', 'exact', '1962-01-01', 'exact', 'Approximate end date 1962');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Newell J. Bryson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-01-01', 'exact', '1962-06-03', 'exact', 'Approximate start date 1962');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'A. Wayne Fox';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-06-03', 'exact', '1963-01-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hal R. Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1963-01-06', 'exact', '1964-01-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'A. Wayne Fox';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1963-01-06', 'exact', '1964-01-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ray L. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1963-01-06', 'exact', '1963-09-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Darrell S. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1963-09-29', 'exact', '1964-01-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bryce W. Memmott';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1964-01-05', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Darrell S. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1964-01-05', 'exact', '1964-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde W. Mills';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1964-05-31', 'exact', '1964-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven S. Davis';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1964-09-27', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde W. Mills';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1964-01-05', 'exact', '1964-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ray A. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1964-05-31', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith E. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1966-01-09', 'exact', '1969-01-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lyle N. Cole';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1966-01-09', 'exact', '1967-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'L. Don LeFevre';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1967-06-04', 'exact', '1969-01-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'L. Don LeFevre';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1966-01-09', 'exact', '1967-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Claude L. Mills';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1967-06-04', 'exact', '1969-01-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David H. Wray';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1969-01-05', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan L. Stine';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1969-01-05', 'exact', '1969-09-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ted F. Powell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1969-09-28', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harvey L. Padley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1969-01-05', 'exact', '1969-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ted F. Powell';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1969-03-16', 'exact', '1969-09-28', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry K. Ward';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1969-09-28', 'exact', '1970-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Edward Dawson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1970-09-27', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ted F. Powell';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1971-01-10', 'exact', '1972-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Edward Dawson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1971-02-25', 'exact', '1971-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan C. Jacobs';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1971-10-10', 'exact', '1972-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan C. Jacobs';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1971-02-25', 'exact', '1971-10-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Flynn';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1971-10-10', 'exact', '1972-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Flynn';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1972-01-09', 'exact', '1975-01-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan C. Jacobs';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1972-01-09', 'exact', '1974-02-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie T. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1974-02-02', 'exact', '1975-01-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie T. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1972-03-19', 'exact', '1974-02-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kay B. Cleverly';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1974-02-02', 'exact', '1975-01-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Flynn';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1975-01-05', 'exact', '1976-01-01', 'year', 'After Jan 1975 stake mission presidency merged with stake seventies quorum presidency');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie T. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1976-01-01', 'year', '1977-02-01', 'year', 'Approximate dates');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'F. Michael Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1977-02-01', 'year', '1982-08-29', 'exact', 'Approximate start date Feb 1977');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Paul Millburn';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1982-08-29', 'exact', '1985-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry D. Veigel';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1985-09-22', 'exact', '1986-08-01', 'year', 'Approximate end date Aug 1986');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie T. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1986-11-23', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James R. Lynch';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1986-11-23', 'exact', '1987-07-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William T. Terry';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1987-07-19', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William T. Terry';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1986-11-23', 'exact', '1987-07-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Buddy K. Funk';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1987-07-19', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Buddy K. Funk';
    SELECT id INTO v_position_id FROM positions WHERE title = '3rd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1986-11-30', 'exact', '1987-07-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Milton K. Shaum';
    SELECT id INTO v_position_id FROM positions WHERE title = '3rd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1987-07-19', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clyde C. Page';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1988-09-25', 'exact', '1992-06-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Buddy K. Funk';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1988-09-25', 'exact', '1989-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Milton K. Shaum';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1989-03-05', 'exact', '1992-06-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Milton K. Shaum';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1988-09-25', 'exact', '1989-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jan V. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1989-03-05', 'exact', '1991-03-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl D. Winger';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1991-03-03', 'exact', '1992-06-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Stephen M. Hadley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '1992-06-14', 'exact', '1995-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delbert H. Strasser';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '1992-06-14', 'exact', '1995-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David M. Williams';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '1992-06-14', 'exact', '1993-04-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake W. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '1993-04-11', 'exact', '1995-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delbert H. Strasser';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '1995-09-10', 'exact', '1996-10-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth D. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '1995-09-10', 'exact', '1996-10-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael W. Crippen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '1995-09-10', 'exact', '1996-10-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Darryl F. Nelson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '1996-10-20', 'exact', '1998-03-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth D. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '1996-10-20', 'exact', '1998-03-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sheral V. Karren';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '1996-10-20', 'exact', '1998-03-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth D. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '1998-03-08', 'exact', '2000-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sheral V. Karren';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '1998-03-08', 'exact', '2000-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ralph E. Angerbauer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '1998-03-08', 'exact', '2000-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark M. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2000-09-10', 'exact', '2002-05-19', 'exact', 'Stake missions discontinued spring 2002');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Richard Hanson Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2000-09-10', 'exact', '2002-05-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jerald W. Duggar';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2000-09-10', 'exact', '2002-05-19', 'exact', NULL);

    -- Stake Patriarch
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Patriarch';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wade H. Pickett';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Patriarch';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1958-04-20', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'C. Lloyd Walch';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Patriarch';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1959-01-11', 'exact', '1971-06-06', 'exact', 'Released to become president of Hawaii Temple');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'C. Lloyd Walch';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Patriarch';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1976-10-17', 'exact', '1987-08-26', 'exact', 'Died in office - second term');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William H. Bennett';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Patriarch';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1964-01-05', 'exact', '1991-01-01', 'year', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lyle R. Peterson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Patriarch';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1971-06-01', 'month', '1995-03-01', 'month', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Rex L. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Patriarch';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '1989-10-15', 'exact', '2011-03-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer R. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Patriarch';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, NULL, '2011-03-06', 'exact', NULL, NULL, 'Current');

    -- Stake Presidency
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Presidency';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ward C. Holbrook';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1964-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'M. Newell Tingey';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1962-09-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delmont Hayes';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1962-09-30', 'exact', '1964-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delmont Hayes';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1962-09-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sterling E. Beesley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1962-09-30', 'exact', '1964-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delmont Hayes';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1964-05-31', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sterling E. Beesley';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1964-05-31', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jay R. Bingham';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1964-05-31', 'exact', '1967-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven S. Davis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1967-06-04', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'F. Burton Howard';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1971-01-10', 'exact', '1978-10-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William Robert McConkie';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1971-01-10', 'exact', '1978-10-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ray L. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1971-01-10', 'exact', '1978-10-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gerald N. Wray';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1978-10-15', 'exact', '1987-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert A. Gelder';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1978-10-15', 'exact', '1985-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn D. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1985-09-22', 'exact', '1987-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Hal R. Belnap';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1978-10-15', 'exact', '1982-09-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn D. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1982-09-26', 'exact', '1985-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer R. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1985-09-22', 'exact', '1987-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'F. Michael Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1987-03-01', 'exact', '1996-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn D. McKee';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1987-03-01', 'exact', '1988-03-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer R. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1988-03-27', 'exact', '1991-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Henry A. Haurand';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1991-09-22', 'exact', '1995-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eugene J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1995-06-11', 'exact', '1996-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer R. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1987-03-01', 'exact', '1988-03-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Henry A. Haurand';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1988-03-27', 'exact', '1991-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eugene J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1991-09-22', 'exact', '1995-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry D. Veigel';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1995-06-11', 'exact', '1996-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry D. Veigel';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1996-09-15', 'exact', '2005-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delbert H. Strasser';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1996-09-15', 'exact', '2005-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance L. Wood';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1996-09-15', 'exact', '2005-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Cory F. Hanks';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '2005-09-11', 'exact', '2014-09-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bret C. Morgan';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '2005-09-11', 'exact', '2014-09-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'L. Kenneth Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '2005-09-11', 'exact', '2014-09-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Troy M. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2014-09-14', 'exact', '2023-08-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew J. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2014-09-14', 'exact', '2023-08-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Margetts';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2014-09-14', 'exact', '2017-09-24', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jerry S. Barker';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2017-09-24', 'exact', '2019-06-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance D. Regis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '2019-06-23', 'exact', '2023-08-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary R. Hill';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2023-08-27', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Adam C. Orson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2023-08-27', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joseph S. Grimstead';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '2023-08-27', 'exact', NULL, NULL, 'Current');

    -- Stake Primary
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Primary';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Maurice J. Clay';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-06-08', 'exact', '1961-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Louise E. Stout';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-06-08', 'exact', '1961-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Arlene C. Moultrie';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-06-08', 'exact', '1961-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Louise E. Stout';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1961-03-19', 'exact', '1967-10-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Arlene C. Moultrie';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1961-03-19', 'exact', '1967-10-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Arlein W. Brown';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1961-03-19', 'exact', '1967-10-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jessene M. Pack';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1967-10-08', 'exact', '1970-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dorothy B. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1967-10-08', 'exact', '1970-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Betty U. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1967-10-08', 'exact', '1970-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dorothy B. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1970-05-31', 'exact', '1972-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Denese P. Adams';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1970-05-31', 'exact', '1972-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marcia D. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1970-05-31', 'exact', '1971-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joyce G. Shaum';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1971-03-12', 'exact', '1972-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Denese P. Adams';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1972-05-12', 'exact', '1975-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joyce G. Shaum';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1972-05-12', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lois L. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1973-06-03', 'exact', '1975-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Janet J. Petersen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1972-05-12', 'exact', '1973-01-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lois L. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1973-01-07', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dixie G. Allen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1973-06-03', 'exact', '1975-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Evelyn M. Beck';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1975-09-12', 'exact', '1976-09-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dixie G. Allen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1975-09-12', 'exact', '1976-09-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lorraine L. Moss';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1975-09-12', 'exact', '1976-01-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn S. Lundquist';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1976-01-11', 'exact', '1976-09-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dixie G. Allen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1976-09-02', 'exact', '1977-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn S. Lundquist';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1976-09-02', 'exact', '1977-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alene B. Pedersen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1976-09-02', 'exact', '1977-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn S. Lundquist';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1977-06-12', 'exact', '1980-02-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alene B. Pedersen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1977-06-12', 'exact', '1977-10-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trudee H. Fuller';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1977-10-16', 'exact', '1979-02-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Meril Lyn Stenquist';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1979-02-09', 'exact', '1979-03-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie D. Lawrence';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1979-03-25', 'exact', '1980-02-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trudee H. Fuller';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1977-06-12', 'exact', '1977-10-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Meril Lyn Stenquist';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1977-10-16', 'exact', '1979-02-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie D. Lawrence';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1979-02-09', 'exact', '1979-03-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lola Mae A. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1979-03-25', 'exact', '1979-10-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LeAnne S. West';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1979-10-14', 'exact', '1980-02-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Leslie D. Lawrence';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1980-02-08', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LeAnne S. West';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1980-02-08', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Barbara P. Julander';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1980-02-08', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LeAnne S. West';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1981-03-01', 'exact', '1983-10-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Barbara P. Julander';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1981-03-01', 'exact', '1983-10-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Betty U. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1981-03-01', 'exact', '1983-10-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Barbara P. Julander';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1983-10-13', 'exact', '1986-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norma J. West';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1983-10-13', 'exact', '1986-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joyce S. Mills';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1983-10-13', 'exact', '1986-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joyce S. Mills';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1986-06-12', 'exact', '1989-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lee Ann C. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1986-06-12', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Susan A. Damm';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1988-09-25', 'exact', '1989-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lonna J. Sadler';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1986-06-12', 'exact', '1988-05-01', 'exact', 'Approximate end date May 1988');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Susan A. Damm';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1988-05-01', 'exact', '1988-09-25', 'exact', 'Approximate start date May 1988');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Thelda Bowers';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1988-09-25', 'exact', '1989-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LaNae W. Simmons';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1989-03-05', 'exact', '1993-09-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norma Jo S. Vance';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1989-03-05', 'exact', '1991-07-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Holly A. Veigel';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1991-07-18', 'exact', '1992-04-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lorraine M. Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1992-04-23', 'exact', '1993-09-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Holly A. Veigel';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1989-03-05', 'exact', '1991-07-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lorraine M. Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1991-07-18', 'exact', '1992-04-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gloria Yeates';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1992-04-23', 'exact', '1993-09-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Betty U. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1993-09-26', 'exact', '1997-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kim M. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1993-09-26', 'exact', '1997-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'JoAnn L. Hanson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1993-09-26', 'exact', '1997-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'JoAnn L. Hanson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1997-09-07', 'exact', '2002-03-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Janeal L. McOmie';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1997-09-07', 'exact', '2002-03-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kristie J. Swain';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1997-09-07', 'exact', '2002-03-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sharon M. Millburn';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2002-03-03', 'exact', '2006-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jolean G. Terry';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2002-03-03', 'exact', '2006-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gina A. Howard';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2002-03-03', 'exact', '2003-06-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Julie W. Dixon';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2003-06-15', 'exact', '2004-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Carol L. Barlow';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2004-03-07', 'exact', '2006-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sherry W. Rodriguez';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2006-03-05', 'exact', '2009-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Judy F. Wallace';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2006-03-05', 'exact', '2009-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Cynthia M. Stanger';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2006-03-05', 'exact', '2007-03-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Susan L. Williams';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2007-03-04', 'exact', '2009-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gina A. Howard';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2009-09-13', 'exact', '2014-04-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sherry M. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2009-09-13', 'exact', '2013-01-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Elaine J. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2013-01-20', 'exact', '2014-04-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Heather D. Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2009-09-13', 'exact', '2012-12-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Syrenna L. Losee';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2012-12-16', 'exact', '2014-04-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Elaine J. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2014-04-26', 'exact', '2018-09-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Stacy L. Knight';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2014-04-26', 'exact', '2015-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Emily J. Miller';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2015-09-13', 'exact', '2018-09-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Emily J. Miller';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2014-04-26', 'exact', '2015-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Cami C. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2015-09-13', 'exact', '2018-09-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norma L. Ostler';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2018-09-09', 'exact', '2022-04-10', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Julie A. Hall';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2018-09-09', 'exact', '2022-04-10', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marla D. Burns';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2018-09-09', 'exact', '2022-04-10', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sylvia R. Steen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2022-04-10', 'exact', '2024-06-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keli A. Rhodes';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2022-04-10', 'exact', '2023-05-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Tracey A. Florence';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2022-04-10', 'exact', '2023-05-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Meredith Palfreyman';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2023-05-21', 'exact', '2024-06-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sara A. Weston';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2023-05-21', 'exact', '2024-06-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sara A. Weston';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2024-06-23', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jamie L. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2024-06-23', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Julie W. Dixon';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2024-06-23', 'exact', NULL, NULL, 'Current');

    -- Stake Relief Society
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Relief Society';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marilla H. Sessions';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1962-03-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Thelma W. Gibson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1962-03-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'DeLoise L. Robins';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1959-06-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Irene C. Hayes';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1959-06-07', 'exact', '1960-10-01', 'exact', 'Approximate end date Oct 1960');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eleanor F. Hoagland';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1960-10-01', 'exact', '1962-03-18', 'exact', 'Approximate start date Oct 1960');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eulala H. Butters';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-03-18', 'exact', '1969-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eleanor F. Hoagland';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-03-18', 'exact', '1962-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vida P. Bennett';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-06-03', 'exact', '1969-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Edith P. Sharp';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-03-18', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'May C. McConkie';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1966-01-09', 'exact', '1969-03-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'May C. McConkie';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1969-03-16', 'exact', '1971-02-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eva C. Chambers';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1969-03-16', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Colleen L. Parker';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1969-03-16', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Helen B. Horner';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1971-02-19', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eldeen W. Trimble';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1971-02-19', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Laureen H. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1971-02-19', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eldeen W. Trimble';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1973-06-03', 'exact', '1979-05-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Laureen H. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1973-06-03', 'exact', '1979-02-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Connie W. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1979-02-09', 'exact', '1979-05-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mehl Ree D. Downard';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1973-06-03', 'exact', '1974-09-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Georgia W. Memmott';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1974-09-29', 'exact', '1979-05-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Connie W. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1979-05-18', 'exact', '1984-03-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joyce A. Cox';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1979-05-18', 'exact', '1982-08-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ada S. Haacke';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1982-08-12', 'exact', '1984-03-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ann S. Allan';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1979-05-18', 'exact', '1984-03-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ada S. Haacke';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1984-03-04', 'exact', '1987-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Elaine N. Carlisle';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1984-03-04', 'exact', '1987-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Diane E. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1984-03-04', 'exact', '1987-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Elaine N. Carlisle';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1987-09-20', 'exact', '1989-10-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Diane E. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1987-09-20', 'exact', '1989-10-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alene B. Pedersen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1987-09-20', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Patsy C. Jeppsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1988-09-25', 'exact', '1989-10-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Carol J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1989-10-15', 'exact', '1991-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ruth W. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1989-10-15', 'exact', '1991-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Myrne M. Collier';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1989-10-15', 'exact', '1991-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ruth W. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1991-09-22', 'exact', '1994-03-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Myrne M. Collier';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1991-09-22', 'exact', '1994-03-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mary Lou B. Strasser';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1991-09-22', 'exact', '1994-03-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Janice E. Tolman';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1994-03-06', 'exact', '1999-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trudee H. Fuller';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1994-03-06', 'exact', '1999-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jenifer J. Scott';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1994-03-06', 'exact', '1999-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Laureen H. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1999-09-12', 'exact', '2006-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Judy R. Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1999-09-12', 'exact', '2006-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Tracey A. Florence';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1999-09-12', 'exact', '2006-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Pamela W. Wood';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2006-03-05', 'exact', '2010-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jana R. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2006-03-05', 'exact', '2010-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Nannette P. White';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2006-03-05', 'exact', '2007-09-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joyce A. Cox';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2007-09-09', 'exact', '2010-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Peggy W. Showalter';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2010-09-12', 'exact', '2015-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Shauna A. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2010-09-12', 'exact', '2015-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Virginia L. Regis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2010-09-12', 'exact', '2015-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Rebecca T. Stahle';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2015-09-13', 'exact', '2020-11-01', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larissa H. Humphries';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2015-09-13', 'exact', '2019-08-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kristi S. Black';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2019-08-04', 'exact', '2020-11-01', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kristi S. Black';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2015-09-13', 'exact', '2019-08-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kathleen S. Burningham';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2019-08-04', 'exact', '2020-11-01', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kami M. Calder';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2020-11-01', 'exact', '2024-06-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michelle D. Misener';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2020-11-01', 'exact', '2023-05-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Julie E. Burdett';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2020-11-01', 'exact', '2023-05-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Deidra Thueson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2023-05-07', 'exact', '2024-06-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jenifer J. Francis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2023-05-07', 'exact', '2024-06-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Andrea L. Regis';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2024-06-09', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Shannon A. Andrews';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2024-06-09', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Shellise Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2024-06-09', 'exact', NULL, NULL, 'Current');

    -- Stake Sunday School
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Sunday School';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dewey C. MacKay Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1962-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard I. Woolley';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1958-06-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clifton I. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-06-08', 'exact', '1961-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'N. Grant Butters';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1961-06-04', 'exact', '1962-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clifton I. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1958-06-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delbert R. Duerden';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-06-08', 'exact', '1961-04-01', 'exact', 'Approximate end date Apr 1961');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert G. Irvine';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1961-04-01', 'exact', '1961-06-04', 'exact', 'Approximate start date Apr 1961');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clifford H. Poulsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1961-06-04', 'exact', '1962-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'A. Carlisle MacKay';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-06-03', 'exact', '1966-10-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gerald W. Day';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-06-03', 'exact', '1964-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LaVance P. Nelson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1964-09-27', 'exact', '1966-10-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John H. Allen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-06-03', 'exact', '1962-09-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LaVance P. Nelson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1962-09-30', 'exact', '1964-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Avon T. Francis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1964-09-27', 'exact', '1966-10-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'M. Newell Tingey';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1966-10-09', 'exact', '1976-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl D. Winger';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1966-10-09', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'A. Tedd Richards';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1971-03-14', 'exact', '1974-01-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John S. Smith';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1974-03-17', 'exact', '1976-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Reese K. Allen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1966-10-09', 'exact', '1967-10-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman T. Marchant';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1967-10-08', 'exact', '1970-11-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard C. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1970-11-19', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John S. Smith';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1971-03-14', 'exact', '1974-03-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl S. Jones';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1974-03-17', 'exact', '1976-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dennis C. Winter';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1976-06-06', 'exact', '1979-03-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Allen L. Vance';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1976-07-13', 'exact', '1979-03-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Donald F. Owen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1976-07-13', 'exact', '1979-03-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Allen L. Vance';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1979-03-25', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blaine J. Kay';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1979-03-25', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vance H. Walker';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1979-03-25', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vance H. Walker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1981-03-01', 'exact', '1983-10-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blaine J. Kay';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1981-03-01', 'exact', '1983-10-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Weldon M. Egbert';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1981-03-01', 'exact', '1983-10-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven L. Brown';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1983-10-30', 'exact', '1987-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith W. Schoenfeld';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1983-10-30', 'exact', '1987-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bryce W. Memmott';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1983-10-30', 'exact', '1987-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl G. Jones';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1987-03-01', 'exact', '1987-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl G. Jones';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1987-09-20', 'exact', '1988-12-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert M. Craven';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1987-09-20', 'exact', '1988-12-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vern N. Christensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1987-09-20', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert D. Davis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1988-09-25', 'exact', '1988-12-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael W. Crippen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1988-12-18', 'exact', '1989-10-15', 'exact', 'No counselors called');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard V. Wall';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1989-10-15', 'exact', '1993-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'George Allan';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1990-01-07', 'exact', '1993-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith Paulsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1990-01-07', 'exact', '1993-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'George Allan';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1993-03-07', 'exact', '1997-06-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry L. Young';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1993-03-07', 'exact', '1995-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Allen Jameson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1995-09-10', 'exact', '1997-06-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Allen Jameson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1993-03-07', 'exact', '1995-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Wallace Cook';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1995-09-10', 'exact', '1997-06-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Allen Jameson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1997-06-29', 'exact', '1999-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Conrad Bowen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1997-06-29', 'exact', '1999-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Denton R. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1997-06-29', 'exact', '1999-09-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen R. Simmons';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1999-09-12', 'exact', '2002-05-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Denton R. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1999-09-12', 'exact', '2001-12-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl M. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2001-12-09', 'exact', '2002-05-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl M. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1999-09-12', 'exact', '2001-12-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Martin L. Halverson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '2001-12-18', 'exact', '2002-05-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Earl M. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2002-05-19', 'exact', '2003-01-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Martin L. Halverson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2002-05-19', 'exact', '2003-01-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'W. Troy Burnett';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '2002-05-19', 'exact', '2003-01-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Donald W. Patterson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2003-01-12', 'exact', '2005-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alvin J. Mitchell';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2003-01-12', 'exact', '2003-06-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David E. Larsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2003-06-15', 'exact', '2005-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'David E. Larsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2003-01-12', 'exact', '2003-06-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gordon L. Fisher';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2003-06-15', 'exact', '2005-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gordon L. Fisher';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2005-09-11', 'exact', '2008-05-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert G. Haire';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2005-09-11', 'exact', '2007-03-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert M. Moncur Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2007-03-04', 'exact', '2007-12-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas W. Osborn';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2007-12-30', 'exact', '2008-05-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ira C. Beal';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2005-09-11', 'exact', '2007-03-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas W. Osborn';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2007-03-04', 'exact', '2007-12-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas B. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2007-12-30', 'exact', '2008-05-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas W. Osborn';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2008-05-04', 'exact', '2012-09-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Douglas B. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2008-05-04', 'exact', '2012-09-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gerald W. Robertson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2008-05-04', 'exact', '2012-09-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith E. Archibald';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2012-09-16', 'exact', '2015-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert M. Craven';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2012-09-16', 'exact', '2015-03-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bruce L. Ashton';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2015-03-08', 'exact', '2015-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Christopher J. Doherty';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2012-09-16', 'exact', '2013-06-18', 'exact', 'Approximate end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bruce L. Ashton';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2013-06-18', 'exact', '2015-03-08', 'exact', 'Approximate start date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dana E. Morgan';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2015-03-08', 'exact', '2015-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kelly M. Barnett';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2015-09-13', 'exact', '2019-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lance D. Beard';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2015-09-13', 'exact', '2019-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clark B. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2015-09-13', 'exact', '2019-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Thomas Woodland';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2019-09-22', 'exact', '2019-11-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joshua A. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2019-09-22', 'exact', '2019-11-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Geoffrey R. Corey';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2019-09-22', 'exact', '2019-11-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clark B. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2019-11-10', 'exact', '2020-11-01', 'exact', 'Handwritten; after Oct 2019 general conference a high council member serves as SS president without counselors');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Aaron M. Coombs';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2020-03-08', 'exact', '2020-11-01', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Curtis E. Bingham';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2020-03-08', 'exact', '2020-11-01', 'exact', 'Handwritten');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Denis B. Longhurst';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2020-12-06', 'exact', '2025-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Aaron M. Coombs';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2021-03-07', 'exact', '2021-11-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Chris D. Partridge';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2021-03-07', 'exact', '2022-04-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marvin A. Magalei';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2022-04-10', 'exact', '2025-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Skyler J. Trujillo';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2022-04-10', 'exact', '2025-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Aaron M. Coombs';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 23, '2025-09-07', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jackson M. Anderson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 23, '2025-11-09', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Nathan J. Arvidson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 23, '2025-11-09', 'exact', NULL, NULL, 'Current');

    -- Stake Young Men
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Young Men';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard G. Sharp';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1959-10-04', 'exact', 'Organization called YMMIA until 1973 then APMIA-Young Men then Aaronic Priesthood then Young Men since 1977');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John E. Ingles';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1958-10-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LaVar C. Murri';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-10-05', 'exact', '1959-10-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'LaVar C. Murri';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1958-10-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Melvin H. Robins';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-10-05', 'exact', '1959-10-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Richard G. Southwick';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1959-10-04', 'exact', '1961-01-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Claine Petersen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1959-10-04', 'exact', '1961-01-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith W. Schoenfeld';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1959-10-04', 'exact', '1961-01-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Claine Petersen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1961-01-08', 'exact', '1961-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith W. Schoenfeld';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1961-01-08', 'exact', '1961-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Weldon H. Woozley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1961-01-08', 'exact', '1961-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith W. Schoenfeld';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1961-06-04', 'exact', '1964-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Weldon H. Woozley';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1961-06-04', 'exact', '1963-02-01', 'exact', 'Approximate end date Feb 1963');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John E. Ingles';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1963-02-17', 'exact', '1964-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lyle N. Cole';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1961-06-04', 'exact', '1962-03-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John E. Ingles';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1962-03-18', 'exact', '1963-02-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bruce J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1963-02-17', 'exact', '1964-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John E. Ingles';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1964-09-27', 'exact', '1965-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Heber B. Kapp';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1964-09-27', 'exact', '1965-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn E. Zabriskie';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1964-09-27', 'exact', '1964-12-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith J. Beazer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1964-12-14', 'exact', '1965-06-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Heber B. Kapp';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1965-06-06', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Keith J. Beazer';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1965-06-06', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gordon L. Carlson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1965-06-06', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'F. Burton Howard';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1966-01-09', 'exact', '1966-06-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gordon L. Carlson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1966-01-09', 'exact', '1966-06-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary G. Cook';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1966-01-09', 'exact', '1966-06-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gordon L. Carlson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Superintendent';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1966-06-05', 'exact', '1970-03-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary G. Cook';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1966-06-05', 'exact', '1966-10-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Rodney Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1966-10-09', 'exact', '1970-03-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Rodney Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1966-06-05', 'exact', '1966-10-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen G. Taylor';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1966-10-09', 'exact', '1967-09-01', 'exact', 'Approximate end date Sep 1967');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Howard S. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Assistant';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1967-11-21', 'exact', '1970-03-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gerald N. Wray';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1970-03-15', 'exact', '1972-11-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert E. Joffs';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1970-03-15', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry D. Hafen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1971-01-10', 'exact', '1972-11-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'R. Randle Romney';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1970-03-15', 'exact', '1970-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Larry D. Hafen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1970-06-25', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harry A. Haycock';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1971-03-21', 'exact', '1972-11-21', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Harry A. Haycock';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1970-09-27', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn E. Zabriskie';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1972-11-21', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth W. Kinzel';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1972-11-21', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ralph E. Angerbauer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1972-11-21', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary L. Wall';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1977-06-12', 'exact', '1978-06-11', 'exact', 'No YM presidency 1973-1977; high councilors on Aaronic Priesthood Committee directed program');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lynn E. Zabriskie';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1977-06-12', 'exact', '1978-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kent W. Hood';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1977-06-12', 'exact', '1978-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kent W. Hood';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1978-06-11', 'exact', '1978-12-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alvin E. Rickers';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1978-06-11', 'exact', '1978-12-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman G. Ainscough';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1978-06-11', 'exact', '1978-12-02', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alvin E. Rickers';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1978-12-02', 'exact', '1980-03-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norman G. Ainscough';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1978-12-02', 'exact', '1979-10-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Doyle L. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1979-10-14', 'exact', '1980-03-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Doyle L. Swenson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1978-12-02', 'exact', '1979-10-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Kunz';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1979-10-14', 'exact', '1980-03-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark M. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1983-01-01', 'year', '1987-09-20', 'exact', 'No YM presidency sustained 1981-1982; high councilors on Aaronic Priesthood Committee directed program 1980-1987');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert J. Little';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1983-01-01', 'year', '1985-01-01', 'year', 'Approximate dates');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Stanley Elmer';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1985-01-01', 'year', '1986-01-01', 'year', 'Approximate dates');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Eugene J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1986-01-01', 'year', '1987-09-20', 'exact', 'Approximate start date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer R. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1983-01-01', 'year', '1985-01-01', 'year', 'Approximate dates');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brian O. Casper';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1985-01-01', 'year', '1986-01-01', 'year', 'Approximate dates');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Paul Millburn';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1986-01-01', 'year', '1987-09-20', 'exact', 'Approximate start date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Clarence C. Neslen Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1987-09-20', 'exact', '1990-06-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary L. Wall';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1987-09-20', 'exact', '1990-06-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Richard Hanson Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '1987-09-20', 'exact', '1990-06-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Thomas V. Foy';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '1990-06-17', 'exact', '1995-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Austin R. Sargent';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '1990-06-17', 'exact', '1995-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Robert K. Lake';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '1990-06-17', 'exact', '1991-06-23', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'James C. Burns';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '1991-06-23', 'exact', '1995-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Terry J. Spallino';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '1995-03-05', 'exact', '1995-12-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jerry S. Barker';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '1995-03-05', 'exact', '1995-12-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth W. Sugden';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '1995-03-05', 'exact', '1995-12-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'J. Duane Moyes';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '1995-12-10', 'exact', '1999-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Claude R. Snow';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '1995-12-10', 'exact', '1999-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth W. Sugden';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '1995-12-10', 'exact', '1996-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mark V. Erickson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '1996-09-15', 'exact', '1997-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeffrey M. Hansen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '1997-09-07', 'exact', '1999-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glen F. Biddulph';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '1999-03-07', 'exact', '2000-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John A. Hermansen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '1999-03-07', 'exact', '2000-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake W. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '1999-03-07', 'exact', '2000-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'G. Tod Moss';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2000-06-04', 'exact', '2001-06-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Craige J. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2000-06-04', 'exact', '2000-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glenn A. Register';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2000-09-10', 'exact', '2001-06-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake W. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2000-06-04', 'exact', '2000-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan P. Ostler';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2000-09-10', 'exact', '2001-06-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lionel B. Farr';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2001-06-10', 'exact', '2004-08-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Glenn A. Register';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2001-06-10', 'exact', '2004-08-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan P. Ostler';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2001-06-10', 'exact', '2002-05-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Scott R. Barnes';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2002-05-19', 'exact', '2004-03-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Walter Scott Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 21, '2004-03-07', 'exact', '2004-08-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Walter Scott Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2004-08-29', 'exact', '2008-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'William T. Terry';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2004-08-29', 'exact', '2007-09-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alan P. Ostler';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2007-09-09', 'exact', '2008-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael T. Mason';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2004-08-29', 'exact', '2007-09-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kenneth P. Schwab';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 22, '2007-09-09', 'exact', '2008-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Blake W. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 23, '2008-09-07', 'exact', '2013-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Steven L. Thueson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 23, '2008-09-07', 'exact', '2011-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bert L. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 23, '2011-09-11', 'exact', '2013-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Bert L. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 23, '2008-09-07', 'exact', '2011-09-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joshua S. Grimstead';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 23, '2011-09-11', 'exact', '2013-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew T. Palfreyman';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 24, '2013-09-08', 'exact', '2016-03-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ted A. Holt';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 24, '2013-09-08', 'exact', '2014-09-14', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew C. Murri';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 24, '2014-11-09', 'exact', '2016-03-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew C. Murri';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 24, '2013-09-08', 'exact', '2014-11-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Spencer L. Winegar';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 24, '2014-11-09', 'exact', '2016-03-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeremy R. Holt';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 25, '2016-03-06', 'exact', '2019-11-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michael J. Esplin';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 25, '2016-03-06', 'exact', '2018-03-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joseph A. Hoggan';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 25, '2018-03-04', 'exact', '2019-11-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'John R. Fennemore';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 25, '2016-03-06', 'exact', '2018-03-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mitchell B. Spence';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 25, '2018-03-04', 'exact', '2019-11-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jason A. Wendel';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 26, '2019-11-10', 'exact', '2020-12-06', 'exact', 'Handwritten end date; after Oct 2019 general conference YM presidency drawn from high council');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brent M. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 26, '2019-11-10', 'exact', '2020-12-06', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Paul E. Barlow';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 26, '2019-11-10', 'exact', '2020-12-06', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Matthew C. Murri';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 27, '2020-12-06', 'exact', '2023-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brent M. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 27, '2020-12-06', 'exact', '2023-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary R. Hill';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 27, '2020-12-06', 'exact', '2023-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Gary R. Hill';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 28, '2023-03-05', 'exact', '2023-12-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Brent M. Watson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 28, '2023-03-05', 'exact', '2023-12-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trevor L. Austin';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 28, '2023-03-05', 'exact', '2023-12-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Roger G. Shumway Jr.';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 29, '2023-12-03', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Samuel J. Bawden';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 29, '2023-12-03', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trevor L. Austin';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 29, '2023-12-03', 'exact', '2024-08-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Samuel D. Johnson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 29, '2024-08-18', 'exact', NULL, NULL, 'Current');

    -- Stake Young Women
    SELECT id INTO v_org_id FROM organizations WHERE name = 'Stake Young Women';

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ethelyn D. Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1960-06-05', 'exact', 'Organization called YWMIA until 1973 then Aaronic Priesthood MIA-Young Women to 1974 then Young Women since 1974');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jean S. Green';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1958-10-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jean T. Francis';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-10-05', 'exact', '1960-06-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delene H. Keddington';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1958-04-20', 'exact', '1959-03-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norma Edwards';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 1, '1959-06-07', 'exact', '1960-06-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Afton S. Beesley';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-06-05', 'exact', '1962-01-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Maxine B. Duerden';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-06-05', 'exact', '1962-01-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dawn H. Bain';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-09-01', 'year', '1960-10-02', 'exact', 'Approximate start date Sep 1960');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Nancy Davis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1960-10-02', 'exact', '1961-01-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lorraine G. Galloway';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 2, '1961-01-08', 'exact', '1962-01-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Helen O. Madsen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1962-01-07', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'June S. Calder';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1962-01-07', 'exact', '1963-09-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Margaret R. Nelson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1963-09-29', 'exact', '1964-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Rhea K. Palmer';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1964-09-27', 'exact', '1965-10-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ardeth G. Kapp';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1965-10-09', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Betty J. Tingey';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1962-03-18', 'exact', '1962-09-30', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Margaret R. Nelson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1962-09-30', 'exact', '1963-09-29', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Rhea K. Palmer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1963-09-29', 'exact', '1964-09-27', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ardeth G. Kapp';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1964-09-27', 'exact', '1965-10-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Carolyn Y. Hunsaker';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 3, '1965-10-09', 'exact', '1966-01-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Carolyn Y. Hunsaker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1966-01-09', 'exact', '1970-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Delores Kelson';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1966-01-09', 'exact', '1966-06-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lois Hoskins';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1966-06-05', 'exact', '1967-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marilyn M. Allen';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1967-03-19', 'exact', '1970-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lois Hoskins';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1966-01-09', 'exact', '1966-06-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marilyn M. Allen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1966-06-05', 'exact', '1967-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Margaret Nielsen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1967-03-19', 'exact', '1967-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Nola Gay Goodfellow';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1967-06-04', 'exact', '1968-03-17', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Linda Stine';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1968-03-17', 'exact', '1969-06-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Valeen S. Jensen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 4, '1969-06-01', 'exact', '1970-05-31', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kathleen K. Lindsay';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1970-05-31', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lois G. Webster';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1970-08-18', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vanda C. Lewis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1970-05-31', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Carolyn L. Bean';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Assistant Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 5, '1970-08-18', 'exact', '1971-01-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lois Hoskins';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1971-02-23', 'exact', '1972-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Nannette Stone';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1971-02-23', 'exact', '1971-11-16', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norma Livingood';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1971-11-16', 'exact', '1972-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'DeLoise L. Robins';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 6, '1971-02-23', 'exact', '1972-03-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Norma Livingood';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1972-03-19', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'DeLoise L. Robins';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1972-03-19', 'exact', '1973-03-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Betty U. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1973-03-18', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sylvia Carter';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1972-03-19', 'exact', '1972-06-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Betty U. Robison';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1972-06-04', 'exact', '1973-03-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dixie G. Allen';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 7, '1973-03-18', 'exact', '1973-06-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Carolyn J. Kunz';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Director';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1973-06-03', 'exact', '1977-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ada S. Haacke';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Laurel Advisor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1973-06-03', 'exact', '1977-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lois Kieffer';
    SELECT id INTO v_position_id FROM positions WHERE title = 'MIA Maid Advisor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1973-06-03', 'exact', '1974-01-06', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Linda Clark';
    SELECT id INTO v_position_id FROM positions WHERE title = 'MIA Maid Advisor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1974-01-13', 'exact', '1977-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Carol J. Moore';
    SELECT id INTO v_position_id FROM positions WHERE title = 'Beehive Advisor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1973-06-03', 'exact', '1977-06-12', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Carolyn J. Kunz';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1977-06-12', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Ada S. Haacke';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1977-06-12', 'exact', '1978-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mary Ann D. Smith';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1978-06-11', 'exact', '1979-02-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lois B. Passey';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1979-02-15', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Mary Ann D. Smith';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1977-06-12', 'exact', '1978-06-11', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lois B. Passey';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1978-06-11', 'exact', '1979-02-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lela M. Bangerter';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 8, '1979-02-15', 'exact', '1981-03-01', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Dorothy McArthur';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1981-03-01', 'exact', '1985-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Wanee I. Welch';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1981-03-01', 'exact', '1982-05-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joanne (Jody) Pratt';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1982-05-19', 'exact', '1985-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Joanne (Jody) Pratt';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1981-03-01', 'exact', '1982-05-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'JoAnn L. Hanson';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 9, '1982-05-19', 'exact', '1985-09-22', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Virginia L. Regis';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1985-09-22', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'JoLyn S. Baldwin';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1985-09-22', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Meredith A. Martinez';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 10, '1985-09-22', 'exact', '1988-09-25', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Alene B. Pedersen';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1988-09-25', 'exact', '1992-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trudee H. Fuller';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1988-09-25', 'exact', '1989-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Judy R. Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1989-03-05', 'exact', '1992-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Judy R. Graham';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1988-09-25', 'exact', '1989-03-05', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Verla Haynie';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 11, '1989-03-05', 'exact', '1992-09-20', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Susan B. Olson';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1992-09-20', 'exact', '1995-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Janette E. Pack';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1992-09-20', 'exact', '1995-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'DiAnne F. Campbell';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 12, '1992-09-20', 'exact', '1995-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'D. Louise DeMoux';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1995-09-10', 'exact', '1998-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Carolyn W. Zaugg';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1995-09-10', 'exact', '1998-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Michelle C. Hanks';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1995-09-10', 'exact', '1997-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sheri B. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 13, '1997-09-07', 'exact', '1998-09-13', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Sheri B. Stark';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1998-09-13', 'exact', '2002-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Laurette Judd';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1998-09-13', 'exact', '2002-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Vicki S. Parsons';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 14, '1998-09-13', 'exact', '2002-09-08', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Laurie G. Barker';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2002-09-08', 'exact', '2007-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kathleen B. Joy';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2002-09-08', 'exact', '2007-09-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Connie M. Burns';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2007-09-09', 'exact', '2008-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Patti K. Williams';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2002-09-08', 'exact', '2003-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Janeal S. Magalei';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2003-09-07', 'exact', '2006-11-04', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Connie M. Burns';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2006-11-04', 'exact', '2007-09-09', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kimberly A. Austin';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 15, '2007-09-09', 'exact', '2008-09-07', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Angela J. Fennemore';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2008-09-07', 'exact', '2014-04-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marilee V. Esplin';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2008-09-07', 'exact', '2014-04-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Marcia R. Mercer';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2008-09-07', 'exact', '2012-05-19', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jennifer L. Tooley';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 16, '2012-05-19', 'exact', '2014-04-26', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Stephanie D. Young';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2014-04-26', 'exact', '2016-09-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Janis F. Reeves';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2014-04-26', 'exact', '2016-09-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Laura A. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 17, '2014-04-26', 'exact', '2016-09-18', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kimberly M. Davis';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2016-09-18', 'exact', '2020-11-01', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Laura A. Brady';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2016-09-18', 'exact', '2017-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Andrea L. Regis';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2017-09-10', 'exact', '2019-03-03', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lee Ann Beard';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2019-03-03', 'exact', '2020-11-01', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Andrea L. Regis';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2016-09-18', 'exact', '2017-09-10', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Trissy J. Bawden';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 18, '2017-09-10', 'exact', '2020-11-01', 'exact', 'Handwritten end date');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Kelli N. Roberts';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2020-11-01', 'exact', '2024-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Jeanene Grimstead';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2020-11-01', 'exact', '2024-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Heidi E. Miner';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 19, '2020-11-01', 'exact', '2024-09-15', 'exact', NULL);

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Lisa D. Wall';
    SELECT id INTO v_position_id FROM positions WHERE title = 'President';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2024-09-15', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Charity Dabel';
    SELECT id INTO v_position_id FROM positions WHERE title = '1st Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2024-09-15', 'exact', NULL, NULL, 'Current');

    SELECT id INTO v_person_id FROM people WHERE full_name = 'Rebecca M. Seegmiller';
    SELECT id INTO v_position_id FROM positions WHERE title = '2nd Counselor';
    INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision, released_date, released_precision, notes)
    VALUES (v_person_id, v_position_id, v_org_id, 20, '2024-09-15', 'exact', NULL, NULL, 'Current');


END $$;

-- ============================================
-- VERIFY IMPORT
-- ============================================

SELECT 'People count: ' || COUNT(*) FROM people;
SELECT 'Callings count: ' || COUNT(*) FROM callings;
SELECT 'Organizations count: ' || COUNT(*) FROM organizations;
